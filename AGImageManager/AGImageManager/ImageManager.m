//
//  ImageManager.m
//  AGImageManager
//
//  Created by Shaik Ghouse Basha on 03/09/15.
//  Copyright (c) 2015 GlobalSoftwareSolutions. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "ImageManager.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFURLRequestSerialization.h"


@implementation ImageManager
- (instancetype)init {
    self.apiKey     =   @"";
    self.folderName =   @"";
    self.tagNames   =   @"";
    
    return self;
}
- (void)uploadImageWithURL:(NSString *)urlString image:(UIImageView *)imageToUpload success:(void (^)(NSDictionary *jsonResponse))successBlock failure:(void (^)(NSError *error))failureBlock{
    NSData* imageData = UIImageJPEGRepresentation(imageToUpload.image, 1.0);

    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:urlString]];
    AFHTTPRequestOperation *operation = [manager POST:urlString parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
    {
        //do not put image inside parameters dictionary as I did, but append it!
        [formData appendPartWithFileData:imageData name:@"image" fileName:@"sample.jpg" mimeType:@"image/jpeg"];
        [formData appendPartWithFormData:[self.apiKey dataUsingEncoding:NSUTF8StringEncoding] name:@"apiKey"];
        [formData appendPartWithFormData:[self.folderName dataUsingEncoding:NSUTF8StringEncoding] name:@"folder"];
        [formData appendPartWithFormData:[self.tagNames dataUsingEncoding:NSUTF8StringEncoding] name:@"tags"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject);
       successBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
        failureBlock(error);
    }];
    manager.requestSerializer.timeoutInterval=600.0;
   [operation start];

  
}

- (void)downloadImageWithURL:(NSString *)urlString completionBlock:(void (^)(BOOL succeeded, NSData *image))completionBlock {
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error ) {
                                   completionBlock(YES,data);
                                   
                               }else{
                                   completionBlock(NO,nil);
                               }
                           }];
}
@end
