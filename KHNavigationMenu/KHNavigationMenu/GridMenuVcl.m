//
//  GridMenuVcl.m
//  KHNavigationMenu
//
//  Created by Khan on 14-10-24.
//  Copyright (c) 2014年 Khan.Lau. All rights reserved.
//

#import "GridMenuVcl.h"
#import "StructMenuItem.h"



@interface MenuCell : UICollectionViewCell

@property(nonatomic, strong) UIImageView *icon;
@property(nonatomic, strong) UILabel * title;

@end



@implementation MenuCell


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
        
    }
    return self;
}



- (void) initView {
    self.icon = [[UIImageView alloc] initWithFrame:CGRectMake((self.contentView.frame.size.width - 39)/2, 5, 39, 39)];
    self.title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height-20, self.contentView.frame.size.width, 20)];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.font = [UIFont systemFontOfSize:12];
    [self.title setTextColor:[UIColor colorWithRed:8.0f/255 green:115.0f/255 blue:167.0f/255 alpha:1.0f]];
    
    
    [self.contentView addSubview:self.icon];
    [self.contentView addSubview:self.title];
}
@end






/////////////////////////////////////
/////////////////////////////////////






@interface GridMenuVcl () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) UIView * backgroundView;
@property (nonatomic, strong) UICollectionView *collectionView;



@end

@implementation GridMenuVcl

static NSString * const reuseIdentifier = @"MenuCollectionCell";


- (id) init {
    self = [super init];
    if (self) {
        _offsetY = 0;
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _offsetY = 0;
    }
    return self;
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _offsetY = 0;
    }
    return self;
}


- (void)viewDidLoad {
    if ([self.delegate respondsToSelector:@selector(loadMenu)]) {
        [self.delegate loadMenu];
    }
    [super viewDidLoad];
    

    [self initView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [self collectionViewWithLayout:flowLayout];
    [self.collectionView registerClass:[MenuCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    if (NSClassFromString(@"UIVisualEffectView") != nil) {
        UIVisualEffectView *v = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
        self.backgroundView = v;
    } else{
        UIToolbar *toolbar = [[UIToolbar alloc] init];
        toolbar.barStyle = UIBarStyleDefault;
        self.backgroundView = toolbar;
    }
    CGSize size = [self preferredContentSize];
    
    self.backgroundView.frame = CGRectMake(0, 0, size.width, size.height);
    self.backgroundView.userInteractionEnabled = YES;
    [self.view addSubview:self.backgroundView];
    
    [self.backgroundView addSubview:self.collectionView];
    [self setupViewConstraints];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (self.data == nil) {
        return 0;
    }
    return [self.data count];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.data == nil) {
        return 0;
    }
    NSString * key = [[self.data allKeys]objectAtIndex:section];
    return [[self.data objectForKey:key] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    NSString * key = [[self.data allKeys]objectAtIndex: [indexPath section]];
    NSArray * arr = [self.data objectForKey:key];
    StructMenuItem * item = [arr objectAtIndex:[indexPath row]];
    
    [cell.icon setImage: [UIImage imageNamed:item.iconName]];
    [cell.title setText: item.content];
    
    [self setCellSelectedBackground:cell];
    return cell;
}


#pragma mark <UICollectionViewDelegate>



- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    NSString * key = [[self.data allKeys]objectAtIndex:[indexPath section]];
    StructMenuItem * item = [[self.data objectForKey:key] objectAtIndex:[indexPath row]];
    
    if ([item.event_target respondsToSelector:item.sector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        [ item.event_target performSelector: item.sector];
#pragma clang diagnostic pop
    }
}





#pragma mark --UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(64, 64);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}








#pragma mark - BlurPopover

- (CGSize)preferredContentSize {
    return CGSizeMake([[UIScreen mainScreen] bounds].size.width , 160);
}

- (void)dismiss {
    NSLog(@"content issued dismissal started");
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"content issued dismissal ended");
    }];
}


-(void) reloadDatasouce{
    [self.collectionView reloadData];
}

#pragma mark - private
- (UICollectionView *)collectionViewWithLayout:(UICollectionViewLayout* )layout {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.userInteractionEnabled = YES;
        _collectionView.scrollsToTop = YES;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
    }
    return _collectionView;
}


- (void)setupViewConstraints {
    NSDictionary *views = @{@"collectionView": self.collectionView };
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-(==%f)-[collectionView]|", self.offsetY] options:0 metrics:nil views:views]];
    [self.backgroundView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|" options:0 metrics:nil views:views]];
}


- (void) setCellSelectedBackground:(MenuCell *) cell {
    UIView *selectView = [[UIView alloc] initWithFrame:CGRectZero];
    UIImageView * img = [[UIImageView alloc] initWithFrame:cell.icon.frame];
    img.image =  [self image:cell.icon.image WithTintColor:[UIColor blueColor]];
    [selectView addSubview:img];
    
    [selectView setBackgroundColor:[UIColor clearColor]];
    [selectView.layer setMasksToBounds:YES];
    [selectView.layer setCornerRadius:3.0];
    [selectView.layer setBorderColor:[[UIColor colorWithRed:217.0f/255 green:217.0f/255 blue:217.0f/255 alpha:1.0f] CGColor]];//边框颜色
    selectView.alpha = 0.3f;
    cell.selectedBackgroundView = selectView;
}

- (UIImage *) image:(UIImage *)image WithTintColor:(UIColor *)tintColor {
    //We want to keep alpha, set opaque to NO; Use 0.0f for scale to use the scale factor of the device’s main screen.
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    [tintColor setFill];
    CGRect bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    UIRectFill(bounds);
    
    //Draw the tinted image in context
    [image drawInRect:bounds blendMode:kCGBlendModeDestinationIn alpha:1.0f];
    
    UIImage *tintedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return tintedImage;
}

@end










