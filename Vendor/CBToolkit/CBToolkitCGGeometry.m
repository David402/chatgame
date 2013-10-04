//
//  CBToolkitCGGeometry.m
//  PicCollage
//
//  Created by yyjim on 12/10/12.
//
//


CGFloat CGDistanceBetweenPoints(CGPoint point1, CGPoint point2) {
    CGFloat dx = point2.x - point1.x;
    CGFloat dy = point2.y - point1.y;
    return sqrt(dx*dx + dy*dy);
}

const CGAffineTransform CGAffineTransformInvalid = { INFINITY, 0, 0, INFINITY, 0, 0 };
BOOL CGAffineTransformIsInvalid(CGAffineTransform t)
{
    return CGAffineTransformEqualToTransform(t, CGAffineTransformInvalid);
}


#pragma mark - CGSize

CGSize CGSizeScale(CGSize size, CGFloat scale)
{
    return CGSizeMake(size.width * scale, size.height * scale);
}
CGSize CGSizeScaleBySize(CGSize size, CGSize scaleSize)
{
    return CGSizeMake(size.width * scaleSize.width, size.height * scaleSize.height);
}
CGFloat CGSizeToArea(CGSize size)
{
    return size.width * size.height;
}

#pragma mark - CGPoint

CGPoint CGPointAdd(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x + p2.x, p1.y + p2.y);
}
CGPoint CGPointSubtract(CGPoint p1, CGPoint p2)
{
    return CGPointMake(p1.x - p2.x, p1.y - p2.y);
}

CGPoint CGPointScale(CGPoint p, CGFloat scale)
{
    return CGPointMake(p.x * scale, p.y * scale);
}

CGPoint CGPointScaleXY(CGPoint p, CGFloat scaleX, CGFloat scaleY)
{
    return CGPointMake(p.x * scaleX, p.y * scaleY);
}

NSUInteger CGPointHash(CGPoint p) {
    return [[NSNumber numberWithDouble:p.x] hash] ^
    [[NSNumber numberWithDouble:p.y] hash];
}

#pragma mark - CGRect

CGRect CGRectTranslate(CGRect rect, CGPoint translation)
{
    return CGRectMake(rect.origin.x + translation.x, rect.origin.y + translation.y,
                      rect.size.width, rect.size.height);
}

CGRect CGRectDenormalize(CGRect rect, CGRect normalRect)
{
    return CGRectMake(normalRect.origin.x + rect.origin.x * normalRect.size.width,
                      normalRect.origin.y + rect.origin.y * normalRect.size.height,
                      rect.size.width  * normalRect.size.width,
                      rect.size.height * normalRect.size.height);
}

extern CGRect CGRectScaleToSize(CGRect rect, CGSize size)
{
    return CGRectMake(rect.origin.x * size.width,
                      rect.origin.y * size.height,
                      rect.size.width * size.width,
                      rect.size.height * size.height);
}

CGRect CGRectApplyAffineTransformAboutPoint(CGRect rect,
                                            CGAffineTransform transform,
                                            CGPoint point)
{
    rect = CGRectTranslate(rect, CGPointScale(point, -1));
    rect = CGRectApplyAffineTransform(rect, transform);
    rect = CGRectTranslate(rect, point);
    return rect;
}
CGRect CGRectCopyWithOriginX(CGRect rect, CGFloat x)
{
    return CGRectMake(x, rect.origin.y,
                      rect.size.width, rect.size.height);
}
CGRect CGRectCopyWithOriginY(CGRect rect, CGFloat y)
{
    return CGRectMake(rect.origin.x, y,
                      rect.size.width, rect.size.height);
}
CGRect CGRectCopyWithWidth(CGRect rect, CGFloat width)
{
    return CGRectMake(rect.origin.x, rect.origin.y,
                      width, rect.size.height);
}
CGRect CGRectCopyWithHeight(CGRect rect, CGFloat height)
{
    return CGRectMake(rect.origin.x, rect.origin.y,
                      rect.size.width, height);
}
