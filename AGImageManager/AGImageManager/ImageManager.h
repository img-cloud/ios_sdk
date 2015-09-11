//
//  ImageManager.h
//  AGImageManager
//
//  Created by Shaik Ghouse Basha on 03/09/15.
//  Copyright (c) 2015 GlobalSoftwareSolutions. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageManager : NSObject
@property (copy, nonatomic) NSString *folderName;
@property (copy, nonatomic) NSString *apiKey;
@property (copy, nonatomic) NSString *tagNames;
@property (copy, nonatomic) NSString *urlString;
- (void)uploadImageWithURL:(NSString *)urlString image:(UIImageView *)imageToUpload success:(void (^)(NSDictionary *jsonResponse))successBlock failure:(void (^)(NSError *error))failureBlock;
- (void)downloadImageWithURL:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, NSData *image))completionBlock;
@end
