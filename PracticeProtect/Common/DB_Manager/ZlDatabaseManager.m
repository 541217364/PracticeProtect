//
//  ZlDatabaseManager.m
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/15.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import "ZlDatabaseManager.h"
#import "FMDB.h"
#import <objc/runtime.h>
#import "DPDatabaseUtils.h"

@interface ZlDatabaseManager ()

@property (nonatomic, strong) FMDatabaseQueue *baseQueue;

@property (nonatomic, copy) NSString *dbFilePath;   //数据库路径

@property (nonatomic, copy) NSString *dbTableName;   //数据库文件名

@property(nonatomic,strong) NSDictionary *primaryDic;

@end

@implementation ZlDatabaseManager

+(instancetype)shareManager{
    static ZlDatabaseManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZlDatabaseManager alloc]init];
    });
    return manager;
}



#pragma mark - 创建数据库表操作

- (BOOL)insertDataWithModel:(id)model withFileName:(NSString *)tableName{
    
    [self getFilePathWithFileName:tableName];
    NSMutableArray *array = [self inserTableSql:model];
    NSString *sql = array[0];
    sql = [NSString stringWithFormat:@"insert into %@ %@",tableName,sql];
    NSMutableArray *proArray = array[1];
    BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
       
    if ([db open]) {
        
        [db setShouldCacheStatements:YES];
        if (![db tableExists:tableName]) {
            
            NSString *createSql = [self getCreateSqlWithtableName:tableName withDataModel:model];
            
            if (createSql && createSql.length > 0) {
                
                if ( [db executeUpdate:createSql]) {
                    
                  result = [db executeUpdate:sql values:proArray error:nil];
                }
            }
        }else{
            
            //存在该表
             result = [db executeUpdate:sql values:proArray error:nil];
        }
        
        }
        [db close];
    }];
   
    return result;
}

#pragma mark 查询数据库

- (NSMutableArray *)selectDataWithModel:(id)model withFileName:(NSString *)tableName withLimit:(NSUInteger)count{
    
    NSMutableArray *selectArray = [NSMutableArray array];
    [self getFilePathWithFileName:tableName];
    
    if (count > 0) {
        //加限制条件
        [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            if ([db open]) {
                if ([db tableExists:tableName]) {
                    
                  FMResultSet *res= [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@  LIMIT %ld",tableName,count]];
                    while ([res next]) {
                        id objc = [[[model class] alloc]init];
                        objc = [self getModel:[model class] withDataDic:[res resultDictionary]];
                        [selectArray addObject:objc];
                    }
                }else{
                    
                    NSLog(@"+++++++++++%@ not find",tableName);
                }
            }
            
            [db close];
        }];
    }else{
        //没有限制条件 获取全部数据
        [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
            if ([db open]) {
                if ([db tableExists:tableName]) {
                    
                    FMResultSet *res= [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ ",tableName]];
                    while ([res next]) {
                        id objc = [[[model class] alloc]init];
                        objc = [self getModel:[model class] withDataDic:[res resultDictionary]];
                        [selectArray addObject:objc];
                    }
                }else{
                    
                    NSLog(@"+++++++++++%@ not find",tableName);
                }
            }
            
            [db close];
        }];
        
    }
    
    return selectArray;
    
}


#pragma mark 更新某一个数据

- (BOOL)updateDataWithModel:(id)model withFileName:(NSString *)tableName withpriamrykey:(NSString *)primaryKey{
    
    [self getFilePathWithFileName:tableName];
    
    NSString *keyPro = self.primaryDic[tableName];
    
    if (!keyPro || keyPro.length == 0) {
        
        NSLog(@"plist文件主键缺失");
        
        return nil;
    }
    
    BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
       
        if ([db open]) {
            
            if ([db tableExists:tableName]) {
                
                NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = ?",tableName,keyPro];
                
                if ([db executeUpdate:sql,primaryKey]) {
                    
                    NSMutableArray *array = [self inserTableSql:model];
                    NSString *sql = array[0];
                    sql = [NSString stringWithFormat:@"insert into %@ %@",tableName,sql];
                    NSMutableArray *proArray = array[1];
    
                    result = [db executeUpdate:sql values:proArray error:nil];
                    
                }
                
            }else{
                
                NSLog(@"++++++++++%@ not find",tableName);
            }
        }
        
        [db close];
    }];
    
    
    return result;
}




#pragma mark 删除某一个数据

- (BOOL)deleteDataWithModel:(NSString *)primaryKey withFileName:(NSString *)tableName{
    
    [self getFilePathWithFileName:tableName];
    
    NSString *keyPro = self.primaryDic[tableName];
    
    if (!keyPro || keyPro.length == 0) {
        
        NSLog(@"plist文件主键缺失");
        
        return nil;
    }
    
    BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
       
        if ([db open]) {
            
            if ([db tableExists:tableName]) {
                
                NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@ = ?",tableName,keyPro];
                
                result = [db executeUpdate:sql,primaryKey];
                
            }else{
                
                NSLog(@"++++++++++%@ not find",tableName);
            }
        }
        [db close];
    }];
    
    
    return result;
}


#pragma mark 删除指定表中所有数据

- (BOOL)deleteDataWithFileName:(NSString *)tableName{
    
    [self getFilePathWithFileName:tableName];
    
     BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
       
        if ([db open]) {
            if ([db tableExists:tableName]) {
                
                NSString *sql = [NSString stringWithFormat:@"delete from %@",tableName];
                result =  [db executeUpdate:sql];
                
            }else{
                
                NSLog(@"++++++++++%@ not find",tableName);
            }
        }
       
        [db close];
    }];
    
    return result;
}

#pragma mark 删除指定表

- (BOOL)dropFileName:(NSString *)tableName{
    
     [self getFilePathWithFileName:tableName];
    
     BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
       
        if ([db open]) {
            
            if ([db tableExists:tableName]) {
                
            NSString *sql = [NSString stringWithFormat:@"drop table %@",tableName];
            result = [db executeUpdate:sql];
                
            }else{
                
                NSLog(@"++++++++++%@ not find",tableName);
            }
        }
       
        [db close];
    }];
    
    
    return result;
}

-(NSString *)getCreateSqlWithtableName:(NSString *)tableName withDataModel:(id)model{
    
    NSString *statementString = @"";
    NSString *primaryKey = self.primaryDic[tableName];
    [self getFilePathWithFileName:tableName];
    if (!primaryKey || primaryKey.length == 0) {
        
        NSLog(@"+++++++++plist文件中未查到该表名");
        
        return nil;
    }
    
    statementString = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ %@",tableName,[self createTableWithMode:model withPrimaryKey:primaryKey]];
    
    return statementString;
}



-(NSString *)createTableWithMode:(id)model withPrimaryKey:(NSString *)primaryKey{
    
    unsigned int numIvars;      //成员变量个数
    NSString *kvarsKey = @"";   //获取成员变量的名字
    NSString *kvarsType = @"";  //成员变量类型
    
    NSMutableArray *kvarsKeyArr = [NSMutableArray array];  //成员变量名字数组
    NSMutableArray *kvarsTypeArr = [NSMutableArray array]; //成员变量类型数组
    
    Ivar *vars = class_copyIvarList([model class], &numIvars);
    
    //获取成员变量名字/类型
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        kvarsKey = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        if ([kvarsKey hasPrefix:@"_"]) {
            kvarsKey = [kvarsKey stringByReplacingOccurrencesOfString:@"_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)];
        }
        kvarsType = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)];
        
        [kvarsKeyArr addObject:kvarsKey];
        [kvarsTypeArr addObject:kvarsType];
    }
    
    NSString *creteSql = @"";
    
    if ([kvarsKeyArr containsObject:primaryKey]) {
        
        for (int i = 0; i < kvarsKeyArr.count; i++) {
            
            NSString *pro = kvarsKeyArr[i];
            NSString *type = kvarsTypeArr[i];
            
            if ([type containsString:@"NSString"]) {
            
                type = @"text";
                
            }else if ([type containsString:@"NSData"]){

                type = @"blob";

            }else{
                
                if ([type containsString:@"NSArray"] ||
                    [type containsString:@"NSMutableArray"] ||
                    [type containsString:@"NSDictionary"] ||
                    [type containsString:@"NSMutableDictionary"]
                    ) {
                    
                    type = @"json";
                    
                }else{
                    
                    NSLog(@"+++++++%@---%@暂时不支持该字段",pro,type);
                }
                
            }
            
            
            
            if ([pro isEqualToString:primaryKey]) {
                
                if (i != 0) {
                    
                    creteSql = [creteSql stringByAppendingString:[NSString stringWithFormat:@",%@ %@ PRIMARY KEY ",pro,type]];
                }else{
                    
                     creteSql = [creteSql stringByAppendingString:[NSString stringWithFormat:@"%@ %@ PRIMARY KEY ",pro,type]];
                }
                
            }else{
                
                if (i != 0) {
                    
                     creteSql = [creteSql stringByAppendingString:[NSString stringWithFormat:@",%@ %@ ",pro,type]];
                }else{
                    
                     creteSql = [creteSql stringByAppendingString:[NSString stringWithFormat:@"%@ %@ ",pro,type]];
                }
            }
            
        }
        
    }else{
        
        NSLog(@"++++++++字段错误，未找到primaryKey");
    }
    
    if (creteSql.length > 0) {
        
        creteSql = [NSString stringWithFormat:@"(%@)",creteSql];
    }
    
    free(vars);
    
    return creteSql;
}


-(NSMutableArray *)inserTableSql:(id)model{
    
    unsigned int numIvars;      //成员变量个数
    NSString *kvarsKey = @"";   //获取成员变量的名字
    NSString *kvarsType = @"";  //成员变量类型
    
    NSMutableArray *kvarsKeyArr = [NSMutableArray array];  //成员变量名字数组
    NSMutableArray *kvarsTypeArr = [NSMutableArray array]; //成员变量类型数组
    NSMutableArray *kvarsValues = [NSMutableArray array]; //成员变量值数组
    
    Ivar *vars = class_copyIvarList([model class], &numIvars);
    
    //获取成员变量名字/类型
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        kvarsKey = [NSString stringWithUTF8String:ivar_getName(thisIvar)];
        if ([kvarsKey hasPrefix:@"_"]) {
            kvarsKey = [kvarsKey stringByReplacingOccurrencesOfString:@"_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)];
        }
        kvarsType = [NSString stringWithUTF8String:ivar_getTypeEncoding(thisIvar)];
        
        [kvarsKeyArr addObject:kvarsKey];
        [kvarsTypeArr addObject:kvarsType];
    }
    
    //拼接字典 key - 变量名称 value - 变量值
    [kvarsKeyArr enumerateObjectsUsingBlock:^(NSString *memberKey, NSUInteger idx, BOOL * _Nonnull stop) {
        id memberValue = [model valueForKey:memberKey]?:@"";
        if ([[kvarsTypeArr objectAtIndex:idx] isEqualToString:@"@"]) { //对id类型数据进行特殊处理
            memberValue = [DPDatabaseUtils setIDVariableToString:[model valueForKey:memberKey]];
        } else if ([[kvarsTypeArr objectAtIndex:idx] containsString:@"NSArray"] ||
                   [[kvarsTypeArr objectAtIndex:idx] containsString:@"NSMutableArray"] ||
                   [[kvarsTypeArr objectAtIndex:idx] containsString:@"NSDictionary"] ||
                   [[kvarsTypeArr objectAtIndex:idx] containsString:@"NSMutableDictionary"]) {
            
            memberValue = [[NSJSONSerialization dataWithJSONObject:[model valueForKey:memberKey] options:NSJSONWritingPrettyPrinted error:nil] base64EncodedStringWithOptions:0];
        }
        [kvarsValues addObject:memberValue];
    }];
    
     NSString *tempStr1 = @"";
     NSString *tempStr2 = @"";
    
    for (int i = 0; i < kvarsKeyArr.count; i ++) {
        
        NSString *pro = kvarsKeyArr[i];

        if (i != 0 ) {
            
           tempStr1 =  [tempStr1 stringByAppendingString:[NSString stringWithFormat:@",%@",pro]];
            
          tempStr2 =  [tempStr2 stringByAppendingString:[NSString stringWithFormat:@",%@",@"?"]];
            
        }else{
            
          tempStr1 =  [tempStr1 stringByAppendingString:pro];
          tempStr2 =  [tempStr2 stringByAppendingString:@"?"];
        }
        
    }
    
    NSString *insertSql = [NSString stringWithFormat:@"(%@)values(%@)",tempStr1,tempStr2];
    
    NSMutableArray *aimArray = [NSMutableArray array];
    
    [aimArray addObject:insertSql];
    
    [aimArray addObject:kvarsValues];
    
    free(vars);
    
    return aimArray;
    
}

// 通过字典获取模型数据
- (id)getModel:(Class)kclass withDataDic:(NSDictionary *)kDic
{
    id objc = [[[kclass class] alloc]init];
    
    unsigned int methodCount = 0;
    NSString *kvarsKey = @"";   //获取成员变量的名字
    NSString *kvarsType = @"";  //成员变量类型
    
    Ivar * ivars = class_copyIvarList([kclass class], &methodCount);
    for (int i = 0 ; i < methodCount; i ++) {
        Ivar ivar = ivars[i];
        kvarsKey = [NSString stringWithUTF8String:ivar_getName(ivar)];
        if ([kvarsKey hasPrefix:@"_"]) {
            kvarsKey = [kvarsKey stringByReplacingOccurrencesOfString:@"_" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, 1)];
        }
        kvarsType = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        
        NSString *ivarValueString = [NSString stringWithFormat:@"%@",[kDic objectForKey:kvarsKey]];
        
        if (!ivarValueString) { continue; }
        
        //实例变量值
        id ivarValue = ivarValueString;
        
        /*  类型码判断
         根据当前Model的成员变量类型,来给变量赋值.
         */
        
        
        //c - char
        if ([kvarsType isEqualToString:@"c"])
            ivarValue = [NSNumber numberWithChar:[ivarValueString intValue]];
        //i - int
        else if ([kvarsType isEqualToString:@"i"])
            ivarValue = [NSNumber numberWithInt:[ivarValueString intValue]];
        //s - short
        else if ([kvarsType isEqualToString:@"s"])
            ivarValue = [NSNumber numberWithShort:[ivarValueString intValue]];
        //l - long
        else if ([kvarsType isEqualToString:@"l"])
            ivarValue = [NSNumber numberWithLong:[ivarValueString intValue]];
        //q - long long
        else if ([kvarsType isEqualToString:@"q"])
            ivarValue = [NSNumber numberWithLongLong:[ivarValueString intValue]];
        //C - unsigned char
        else if ([kvarsType isEqualToString:@"C"])
            ivarValue = [NSNumber numberWithUnsignedChar:[ivarValueString intValue]];
        //I - unsigned int
        else if ([kvarsType isEqualToString:@"I"])
            ivarValue = [NSNumber numberWithUnsignedInt:[ivarValueString intValue]];
        //S - unsigned short
        else if ([kvarsType isEqualToString:@"S"])
            ivarValue = [NSNumber numberWithUnsignedShort:[ivarValueString intValue]];
        //L - unsigned long
        else if ([kvarsType isEqualToString:@"L"])
            ivarValue = [NSNumber numberWithUnsignedLong:[ivarValueString intValue]];
        //Q - unsigned long long
        else if ([kvarsType isEqualToString:@"Q"])
            ivarValue = [NSNumber numberWithUnsignedLongLong:[ivarValueString intValue]];
        //f - float
        else if ([kvarsType isEqualToString:@"f"])
            ivarValue = [NSNumber numberWithFloat:[ivarValueString floatValue]];
        //d - double
        else if ([kvarsType isEqualToString:@"d"])
            ivarValue = [NSNumber numberWithDouble:[ivarValueString doubleValue]];
        //B - bool or a C99 _Bool
        else if ([kvarsType isEqualToString:@"B"]) {
            if ([ivarValueString isEqualToString:@"1"]) {
                ivarValue = [NSNumber numberWithBool:YES];
            } else {
                ivarValue = [NSNumber numberWithBool:NO];
            }
        }
        //v - void
        //        else if ([kvarsType isEqualToString:@"v"]) {}
        //* - char *
        //        else if ([kvarsType isEqualToString:@"*"]) {}
        //@ - id
        else if ([kvarsType isEqualToString:@"@"]) {
            ivarValue = [DPDatabaseUtils getIDVariableValueTypesWithString:ivarValueString];
        }
        //# - Class
        //        else if ([kvarsType isEqualToString:@"#"]) {}
        //: - SEL
        //        else if ([kvarsType isEqualToString:@":"]) {}
        //@"NSArray" - array
        else if ([kvarsType containsString:@"NSArray"]          ||
                 [kvarsType containsString:@"NSMutableArray"]   ||
                 [kvarsType containsString:@"NSDictionary"]     ||
                 [kvarsType containsString:@"NSMutableDictionary"]) {
            
            ivarValue = [NSJSONSerialization JSONObjectWithData:[[NSData alloc]initWithBase64EncodedString:[kDic objectForKey:kvarsKey] options:0] options:NSJSONReadingMutableLeaves error:nil];
        }
        //? - unknown type
        else {
            ivarValue = ivarValueString;
        }
        
        [objc setValue:ivarValue forKey:kvarsKey];
    }
    free(ivars);
    return objc;
}

//获取文件路径
- (void)getFilePathWithFileName:(NSString *)fileName
{
    NSAssert(fileName || ![fileName isEqualToString:@""], @"数据库文件名不可为空!");
    _dbTableName = [@"DBA" stringByAppendingString:fileName];
    _dbFilePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db",_dbTableName]];
    NSLog(@"%@",_dbFilePath);
}

- (FMDatabaseQueue *)baseQueue
{
    if (!_baseQueue) {
        _baseQueue = [FMDatabaseQueue databaseQueueWithPath:_dbFilePath];
    }
    return _baseQueue;
}

- (NSDictionary *)primaryDic{
    if (_primaryDic == nil) {
        NSString* tablePlistPath = [[NSBundle mainBundle] pathForResource:@"ZLDatabaseTableName" ofType:@"plist"];
        _primaryDic = [[NSDictionary alloc]initWithContentsOfFile:tablePlistPath];
    }
    return _primaryDic;
}




#pragma mark  处理图片的两个方法

//图片转换base64
- (NSString *)imageToString:(UIImage *)image{
    
    NSData *imagedata = UIImagePNGRepresentation(image);
    
    NSString *image64 = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    return image64;
    
}
//base64转换图片
- (UIImage *)stringToImage:(NSString *)str {
    
    NSData * imageData =[[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    UIImage *photo = [UIImage imageWithData:imageData];
    
    return photo;
    
}



@end
