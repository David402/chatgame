//
//  StickerCell.m
//  chatgame
//
//  Created by David Liu on 2/1/13.
//  Copyright (c) 2013 Cardinal Blue. All rights reserved.
//

#import "Utils.h"
#import "Configuration.h"
#import "StickerCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation StickerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    self.thumbnail = [[[UIImageView alloc] initWithFrame:CGRectMake(CGPointZero.x, CGPointZero.y, STICKER_TABLE_HEIGHT, WINSIZE.width)] autorelease];
    self.thumbnail.opaque = YES;
    self.thumbnail.layer.masksToBounds = YES;
    self.thumbnail.layer.cornerRadius = 8.0f;
    
    [self.contentView addSubview:self.thumbnail];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.transform = CGAffineTransformMakeRotation(M_PI * 0.5);
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (NSString *)reuseIdentifier
{
    return @"StickerCell";
}

- (void)dealloc
{
    [_thumbnail release];
    [super dealloc];
}
@end
