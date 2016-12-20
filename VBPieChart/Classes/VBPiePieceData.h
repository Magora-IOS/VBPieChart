#import <UIKit/UIKit.h>


@interface VBPiePieceData : NSObject
@property (nonatomic) NSInteger index;
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSNumber *value;
@property (nonatomic, retain) UIColor *color;
@property (nonatomic, retain) UIColor *labelColor;
@property (nonatomic, retain) UIColor *strokeColor;
@property (nonatomic) BOOL accent;

+ (UIColor*) defaultColors:(NSInteger)index;
+ (VBPiePieceData*) pieceDataWith:(NSDictionary*)object;
@end
