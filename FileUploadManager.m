//
//  FileUploadManager.m
//  AFNDemo
//
//  Created by 喻永权 on 2018/9/18.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import "FileUploadManager.h"

@implementation FileUploadManager

+ (id)shareIntance{
    static FileUploadManager *fileLoad = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        fileLoad = [[FileUploadManager alloc]init];
    });
    return fileLoad;
}

- (void)uploadFileWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSString *)filePath{
    [self uploadFileWithUrlString:urlString serviceFileName:serviceFileName filePath:filePath textDict:nil];
}

- (void)uploadFilesWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSArray *)filePaths{
    [self uploadFilesWithUrlString:urlString serviceFileName:serviceFileName filePath:filePaths textDict:nil];
}

- (void)uploadFileWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSString *)filePath textDict:(NSDictionary *)dict{
    [self uploadFilesWithUrlString:urlString serviceFileName:serviceFileName filePath:@[filePath] textDict:dict];
}

- (void)uploadFilesWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSArray *)filePaths textDict:(NSDictionary *)dict{
    NSURL *url = [NSURL URLWithString: urlString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [request setHTTPMethod:@"POST"];//设置请求方式
    //设置请求头
    [request setValue:@"multipart/form-data; boundary=itcast" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:[self getHTTPBodyWithServerFileName:serviceFileName filePaths:filePaths textDict:dict]];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        // 处理响应
        if (connectionError == nil && data != nil) {
            
            // 反序列化
            NSArray *result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSLog(@"result:%@",result);
            
        } else {
            NSLog(@"error:%@",connectionError);
        }
    }];
    
}

- (NSData *)getHTTPBodyWithServerFileName:(NSString *)serverFileName filePaths:(NSArray *)filePaths textDict:(NSDictionary *)textDict {
    // 定义可变的二进制容器,用于拼接整个请求体二进制信息
    NSMutableData *dataM = [NSMutableData data];
    
    // 拼接图片文件的二进制请求体信息
    [filePaths enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        // 定义可变的字符串拼接图片二进制数据之前的字符串
        NSMutableString *stringM = [NSMutableString string];
        
        // 拼接文件开始的分隔符
        [stringM appendString:@"\r\n--mac\r\n"];
        // 拼接表单数据
        [stringM appendFormat:@"Content-Disposition: form-data; name=%@; filename=%@",serverFileName,[obj lastPathComponent]];
        // 拼接文件类型 : 我不希望告诉服务器我的文件类型,采用8进制流的类型
        [stringM appendString:@"Content-Type: application/octet-stream"];
        // 拼接单纯的换行
        [stringM appendString:@"\r\n"];
        // 直接把图片二进制数据之前的字符串转成二进制,拼接到我们的请求体信息里面去
        [dataM appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];
        
        // 拼接图片/文件的二进制数据
        [dataM appendData:[NSData dataWithContentsOfFile:obj]];
        
        // 拼接最后的换行
        NSString *br = @"\r\n";
        [dataM appendData:[br dataUsingEncoding:NSUTF8StringEncoding]];
         NSLog(@"%@",stringM);
    }];
    
    // 拼接文件上传时的文本信息的请求体信息
    [textDict enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        
        // 定义可变的字符串,拼接文件上传时的文本信息
        NSMutableString *stringM = [NSMutableString string];
        // 拼接文本信息开始的分隔符
        [stringM appendString:@"----------------mac\r\n"];
        // 拼接表单数据
        [stringM appendFormat:@"Content-Disposition: form-data; name=%@\r\n",key];
        // 拼接单纯的换行
        [stringM appendString:@"\r\n"];
        // 拼接文本信息
        [stringM appendFormat:@"%@\r\n",obj];
        
        // 把文本信息的请求体二进制添加到dataM
        [dataM appendData:[stringM dataUsingEncoding:NSUTF8StringEncoding]];
        [stringM appendString:@"----------------mac\r\n"];
        NSLog(@"%@",stringM);
    }];
    
    // 拼接文件上传时的结束分隔符
    NSString *end = @"--mac--";
    NSLog(@"%@",end);
    [dataM appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    
    //修改旧对象，生成新对象  （将可变数组改为不可变数组）
    NSLog(@"body:==>%@",dataM);
    return dataM.copy;
}

@end
