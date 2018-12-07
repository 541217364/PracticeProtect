//
//  ViewController.m
//  PracticeProtect
//
//  Created by 周启磊 on 2018/10/18.
//  Copyright © 2018年 DianBeiWaiMai. All rights reserved.
//

#import "ViewController.h"
#import "ZipArchive.h"
@interface ViewController ()<WXApiDelegate>

@end

@implementation ViewController

{
    
    NSString*path;
    
    NSString*zipPath;
    
    ZipArchive*zip;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self downloadZipFiles];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)downloadZipFiles{
    dispatch_queue_t queue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0);
    dispatch_async(queue, ^{NSURL*url = [NSURL URLWithString:@"http://www.icodeblog.com/wp-content/uploads/2012/08/zipfile.zip"];
        NSError*error =nil;
        NSData*data = [NSData dataWithContentsOfURL:url options:0 error:nil];
        if(!error){
        NSArray*pathes =NSSearchPathForDirectoriesInDomains(NSCachesDirectory,NSUserDomainMask,YES);
            self->path= [pathes objectAtIndex:0];
            self->zipPath= [self->path stringByAppendingPathComponent:@"zipfile.zip"];
            [data writeToFile:self->zipPath options:0 error:nil];//解压zip文件
        [self releaseZipFiles];
                }
        
             }
        );
    }
    
- (void)releaseZipFiles{
    
    zip= [[ZipArchive alloc]init];
    //1.在内存中解压缩文件,
    if([zip UnzipOpenFile:zipPath]){
        //2.将解压缩的内容写到缓存目录中
        BOOL ret = [zip UnzipFileTo:path overWrite:YES];
        if(NO== ret) {
            [zip UnzipCloseFile];
            
        }
        
    }
    
    
    //3.使用解压缩后的文件
    NSString*imageFilePath = [path stringByAppendingPathComponent:@"photo.png"];
    NSString*textPath = [path stringByAppendingPathComponent:@"text.txt"];
    NSData*imageData = [NSData dataWithContentsOfFile:imageFilePath options:0 error:nil];
    UIImage*image = [UIImage imageWithData:imageData];
    NSString*string = [NSString stringWithContentsOfFile:textPath encoding:NSASCIIStringEncoding error:nil];
    
    
    //4.更新UI
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
//        _headImageView.image= image;
//
//        _IntroduceLabel.text= string;
        
    });
    
    
    
    //压缩zip文件,压缩文件名
    NSString*createZipPath = [path stringByAppendingPathComponent:@"myFile.zip"];
    //判断文件是否存在，如果存在则删除文件
    NSFileManager * fileManager = [NSFileManager defaultManager];
    
    @try
    {
        if([fileManager fileExistsAtPath:createZipPath])
        {
            if(![fileManager removeItemAtPath:createZipPath error:nil])
        {
            NSLog(@"Delete zip file failure.");
            
        }
            
        }
        
    }
    
    @catch(NSException * exception) {
        
        NSLog(@"%@",exception);
        
    }
    
    
    
    //判断需要压缩的文件是否为空
    if(string.length<1)
    {
        NSLog(@"The files want zip is nil.");
       
        
    }
    [zip CreateZipFile2:createZipPath];
    //解压缩文件名
    [zip addFileToZip:textPath newname:@"Words.txt"];
    NSLog(@"%@",textPath);
    [zip CloseZipFile2];
    

    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
//    req.bText = YES;
//    req.text = @"分享的内容";
//    req.scene = WXSceneSession;
//    [WXApi sendReq:req];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
