//
//  UIImage+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "NSError+CB.h"
#import "UIScreen+CB.h"
#import "UIImage+CB.h"

@implementation UIImage (CB)
- (UIImage *)safeResizableImageWithCapInsets:(UIEdgeInsets)capInsets
{
    if ([self respondsToSelector:@selector(resizableImageWithCapInsets:)])
        return [self resizableImageWithCapInsets:capInsets];
    // else
    return [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
+ (UIImage *)imageWithPatternImage:(UIImage *)patternImage size:(CGSize)size
{
    return [UIImage imageWithColor:[UIColor colorWithPatternImage:patternImage]
                              size:size];
}

+ (UIImage *)imageWithContentsOfURL:(NSURL *)url
                            timeout:(NSTimeInterval)timeout
                              error:(NSError **)outError
{
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:60];
    NSHTTPURLResponse *response = nil;
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:&response
                                                     error:&error];
    if (error) {
        if (outError != NULL)
            *outError = error;
        return nil;
    }
    
    if (response.statusCode != 200) {
        NSString *reason = [NSString stringWithFormat:@"Http response status code %d", response.statusCode];
        if (outError != NULL) {
            *outError = [NSError errorWithDomain:@"UIImage+CB" code:500
                            localizedDescription:@""
                          localizedFailureReason:reason];
        }
        return nil;
    }

    if (!data) {
        if (outError != NULL) {
            *outError = [NSError errorWithDomain:@"UIImage+CB" code:501
                            localizedDescription:@"Can't load image"
                          localizedFailureReason:@"No response data"];
        }
        return nil;
    }
    
    return [UIImage imageWithData:data];
}

@end

// =============================================================================

@implementation UIImage (ImageNamedExtension)

+ (UIImage *)imageNamed:(NSString *)name
          fromDirectory:(NSString *)directory
{
    NSFileManager *fileManager = [[[NSFileManager alloc] init] autorelease];
    
    // Find image with device suffix
    NSString *deviceSuffix = @"";
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        deviceSuffix = @"~iphone";
    else if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        deviceSuffix = @"~ipad";
    
    NSString *name1xDevice = [name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", [name pathExtension]]
                                                             withString:[NSString stringWithFormat:@"%@.%@", deviceSuffix, [name pathExtension]]];
    NSString *name2xDevice = [name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", [name pathExtension]]
                                                             withString:[NSString stringWithFormat:@"@2x%@.%@", deviceSuffix, [name pathExtension]]];
    NSString *path1xDevice = [directory stringByAppendingPathComponent:name1xDevice];
    NSString *path2xDevice = [directory stringByAppendingPathComponent:name2xDevice];
    
    if ([[UIScreen mainScreen] isRetinaDisplay]) {
        if ([fileManager fileExistsAtPath:path2xDevice])
            return [UIImage imageWithContentsOfFile:path2xDevice];
    }
    
    if ([fileManager fileExistsAtPath:path1xDevice])
        return [UIImage imageWithContentsOfFile:path1xDevice];
    
    // Find image without device suffix
    NSString *name1x = [NSString stringWithString:name];
    NSString *name2x = [name stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@".%@", [name pathExtension]]
                                                       withString:[NSString stringWithFormat:@"@2x.%@", [name pathExtension]]];
    NSString *path1x = [directory stringByAppendingPathComponent:name1x];
    NSString *path2x = [directory stringByAppendingPathComponent:name2x];
    
    if ([[UIScreen mainScreen] isRetinaDisplay]) {
        if ([fileManager fileExistsAtPath:path2x])
            return [UIImage imageWithContentsOfFile:path2x];
    }
    
    if ([fileManager fileExistsAtPath:path1x])
        return [UIImage imageWithContentsOfFile:path1x];
    
    return nil;
}
@end

// =============================================================================

@implementation UIImage (Border)
// This method creates a width+2+3 x width+2+3 image
+ (UIImage *)imageWithBorderWidth:(NSInteger)width color:(UIColor *)color
{
    CGSize size = CGSizeMake(width*2+2+3, width*2+2+3);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Fill with alpha
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    // Draw border
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(1, 1, width*2+3, width*2+3));
    
    // Draw center hole
    CGContextClearRect(context, CGRectMake(width+1, width+1, 3, 3));
    
    // Export to image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithClearBorderColor:(UIColor *)color
{
    CGSize size = CGSizeMake(5, 5);
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Fill with alpha
    CGContextClearRect(context, CGRectMake(0, 0, size.width, size.height));
    
    // Draw border
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, CGRectMake(1, 1, 3, 3));
    
    // Export to image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Set insets
    NSInteger inset = 2;
    if ([image respondsToSelector:@selector(resizableImageWithCapInsets:)]) {
        UIEdgeInsets insets = { inset, inset, inset, inset };
        image = [image resizableImageWithCapInsets:insets];
    }
    else
        image = [image stretchableImageWithLeftCapWidth:inset
                                           topCapHeight:inset];
    
    // Return
    return image;
}
@end
