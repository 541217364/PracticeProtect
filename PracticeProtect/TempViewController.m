//
//  TempViewController.m
//  PracticeProtect
//
//  Created by 弦断有谁听 on 2018/12/24.
//  Copyright © 2018 DianBeiWaiMai. All rights reserved.
//

#import "TempViewController.h"
#import <DateTools.h>
#import "MPTextView.h"
#import <UICKeyChainStore.h>
@interface TempViewController ()
@property (nonatomic, strong) iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *items;
@end

@implementation TempViewController

@synthesize items;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
//    self.carousel = [[iCarousel alloc]initWithFrame:self.view.bounds];
//    self.carousel.delegate = self;
//    self.carousel.dataSource = self;
//    self.carousel.backgroundColor = [UIColor redColor];
//    self.carousel.type = iCarouselTypeInvertedCylinder;
//    [self.view addSubview:self.carousel];
    
    NSDate *timeAgoDate = [NSDate dateWithTimeIntervalSinceNow:-4];
    NSLog(@"Time Ago: %@", timeAgoDate.timeAgoSinceNow);
    NSLog(@"Time Ago: %@", timeAgoDate.shortTimeAgoSinceNow);
    
    
    MPTextView *textView = [[MPTextView alloc]initWithFrame:CGRectMake(0, 200, 200, 50)];
    
    textView.placeholderText = @"ddddddddd";
    textView.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:textView];
    
    UICKeyChainStore *keychainStore = [UICKeyChainStore keyChainStore] ;
    [keychainStore setString:@"password" forKey:@"123456"];
    NSLog(@"--------++++%@", [[UICKeyChainStore keyChainStore] stringForKey:@"123456"]);
   
}

- (void)setUp
{
    //set up data
    self.items = [NSMutableArray array];
    for (int i = 0; i < 1000; i++)
    {
        [items addObject:@(i)];
    }
}

#pragma mark -
#pragma mark iCarousel methods

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //generate 100 buttons
    //normally we'd use a backing array
    //as shown in the basic iOS example
    //but for this example we haven't bothered
    return 100;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    UIButton *button = (UIButton *)view;
    if (button == nil)
    {
        //no button available to recycle, so create new one
        UIImage *image = [UIImage imageNamed:@"page.png"];
        button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0.0f, 0.0f, image.size.width, image.size.height);
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setBackgroundImage:image forState:UIControlStateNormal];
        button.titleLabel.font = [button.titleLabel.font fontWithSize:50];
        [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //set button label
    [button setTitle:[NSString stringWithFormat:@"%zd", index] forState:UIControlStateNormal];
    
    return button;
}

#pragma mark -
#pragma mark Button tap event

- (void)buttonTapped:(UIButton *)sender
{
    //get item index for button
    NSLog(@"1111111");
    NSInteger index = [self.carousel indexOfItemView:sender];

    [[[UIAlertView alloc] initWithTitle:@"Button Tapped"
                                message:[NSString stringWithFormat:@"You tapped button number %zd", index]
                               delegate:nil
                      cancelButtonTitle:@"OK"
                      otherButtonTitles:nil] show];
}


@end
