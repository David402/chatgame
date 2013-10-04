//
//  ALAssetsLibrary+CB.h
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import <AssetsLibrary/AssetsLibrary.h>

@interface ALAssetsLibrary (CB)
+ (ALAssetsLibrary *)sharedInstance;
+ (ALAssetsLibrary *)newInstance;
@end
