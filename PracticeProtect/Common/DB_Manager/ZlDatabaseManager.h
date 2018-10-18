//
//  ZlDatabaseManager.h
//  ToolsDemo
//
//  Created by 周启磊 on 2018/10/15.
//  Copyright © 2018年 DIDIWAIMAI. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZlDatabaseManager : NSObject

/*
 * 实例化
 */


+(instancetype)shareManager;

/* 创建表
 *
 * @param  model    所需存储的Model数据 属性全部为字符串 需要存储图片 通过下面的方法转换
 * model的属性值必须和数据库的属性值字段一致
 *
 *@param  tableName 表名
 */
- (BOOL)insertDataWithModel:(id)model withFileName:(NSString *)tableName;


/* 查询表
 *
 * @param  model    所需存储的Model数据
 * @param  tableName 表名
 *
 * @return 是否创建或插入成功
 */
- (NSMutableArray *)selectDataWithModel:(id)model withFileName:(NSString *)tableName withLimit:(NSUInteger)count;



/* 更新某一个数据
 *
 * @param  model    所需存储的Model数据
 * @param  tableName 表名
 *
 * @return 是否更新成功
 */
- (BOOL)updateDataWithModel:(id)model withFileName:(NSString *)tableName withpriamrykey:(NSString *)primaryKey;


/* 删除某一个数据
 *
 * @param  model_primaryKey    所需存储的主键
 * @param  tableName 表名
 *
 * @return 是否更新成功
 */

- (BOOL)deleteDataWithModel:(NSString *)primaryKey withFileName:(NSString *)tableName;


/* 删除表中所有数据
 *
 *
 * @param  tableName 表名
 *
 * @return 是否删除成功
 */

- (BOOL)deleteDataWithFileName:(NSString *)tableName;



/* 删除表
 *
 *
 * @param  tableName 表名
 *
 * @return 是否删除成功
 */
- (BOOL)dropFileName:(NSString *)tableName;




/* base64 图片转换
 *
 *
 *
 */
- (NSString *)imageToString:(UIImage *)image;

- (UIImage *)stringToImage:(NSString *)str ;



@end
