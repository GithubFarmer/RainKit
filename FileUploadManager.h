//
//  FileUploadManager.h
//  AFNDemo
//
//  Created by 喻永权 on 2018/9/18.
//  Copyright © 2018年 喻永权. All rights reserved.
//

#import <Foundation/Foundation.h>
/** 文件上传了类 */
@interface FileUploadManager : NSObject

+ (id)shareIntance;

/** 单文件上传不带文本 */
- (void)uploadFileWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSString *)filePath;

/** 单文件上传带文本 */
- (void)uploadFileWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSString *)filePath textDict:(NSDictionary *)dict;

/** 多文件上传不带文本 */
- (void)uploadFilesWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSArray *)filePaths;

/** 多文件上传不带文本 */
- (void)uploadFilesWithUrlString:(NSString *)urlString serviceFileName:(NSString *)serviceFileName filePath:(NSArray *)filePaths textDict:(NSDictionary *)dict;

@end
