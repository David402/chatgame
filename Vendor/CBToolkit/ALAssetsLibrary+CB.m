//
//  ALAssetsLibrary+CB.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//

#import "ALAssetsLibrary+CB.h"

@implementation ALAssetsLibrary (CB)
static ALAssetsLibrary *_ALAssetsLibrarySharedInstance = nil;

+ (ALAssetsLibrary *)sharedInstance
{
    @synchronized(self) {
        if (!_ALAssetsLibrarySharedInstance)
            _ALAssetsLibrarySharedInstance = [[ALAssetsLibrary alloc] init];
        return _ALAssetsLibrarySharedInstance;
    }
}
+ (ALAssetsLibrary *)newInstance
{
    @synchronized(self) {
        [_ALAssetsLibrarySharedInstance release];
        _ALAssetsLibrarySharedInstance = [[ALAssetsLibrary alloc] init];
        // Handle iOS5 issue
        // We need to call it immediately after creating instance ALAssetsLibrary,
        // otherwise ALAssetsLibraryChangedNotification won't call. 
        [_ALAssetsLibrarySharedInstance writeImageToSavedPhotosAlbum:nil
                                                            metadata:nil
                                                     completionBlock:nil];
        return _ALAssetsLibrarySharedInstance;
    }
}
@end
