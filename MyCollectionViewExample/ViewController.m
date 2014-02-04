//
//  ViewController.m
//  MyCollectionViewExample
//
//  Created by Milan Kumar Panchal on 04/02/14.
//  Copyright (c) 2014 Pantech. All rights reserved.
//

#import "ViewController.h"
#import "MyCollectionViewCell.h"

@import QuartzCore;

@interface ViewController ()

@end

static NSString *kCollectionViewCellIdentifier = @"Cells";
const NSTimeInterval kAnimationDuration = 0.4;


@implementation ViewController

#pragma mark - View life cycle methods


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView methods

- (instancetype) initWithCollectionViewLayout:(UICollectionViewLayout *)layout{
    self = [super initWithCollectionViewLayout:layout];
    
    if (self != nil){
        UINib *nib = [UINib nibWithNibName:
                      NSStringFromClass([MyCollectionViewCell class])
                                    bundle:[NSBundle mainBundle]];
        [self.collectionView registerNib:nib forCellWithReuseIdentifier:kCollectionViewCellIdentifier];
    }
    return self;
}


- (NSInteger)numberOfSectionsInCollectionView :(UICollectionView *)collectionView{
    return 2;

}

/* For now, we won't return any sections */
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return arc4random_uniform(10)+10;
}


/* We don't yet know how we can return cells to the collection view so
 let's return nil for now */
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
  
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellIdentifier
                                                                           forIndexPath:indexPath];
    
    cell.imgView.image = [self randomImage];
    cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
    cell.layer.borderWidth = 2.0f;
    cell.layer.borderColor = [[UIColor grayColor] CGColor];
    
    return cell;
}


//- (void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
    
//    [UIView animateWithDuration:kAnimationDuration animations:^{
//        selectedCell.alpha = 0.0f;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:kAnimationDuration animations:^{
//            selectedCell.alpha = 1.0f;
//        }];
//    }];
//}

//- (void) collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
//    [UIView animateWithDuration:kAnimationDuration animations:^{
//        selectedCell.transform = CGAffineTransformMakeScale(2.0f, 2.0f);
//    }];
//
//}
//- (void) collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath{
//    UICollectionViewCell *selectedCell = [collectionView cellForItemAtIndexPath:indexPath];
//    
//    [UIView animateWithDuration:kAnimationDuration animations:^{
//        selectedCell.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
//    }];
//}

- (BOOL) collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath{
    return YES;

}

- (BOOL) collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{

    if (action == @selector(copy:)){
        return YES;
    }
    
    return NO;
}

- (void) collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    if (action == @selector(copy:)){
        MyCollectionViewCell *cell = (MyCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        [[UIPasteboard generalPasteboard] setImage:cell.imgView.image];
    }
}

- (NSArray *) allImages{
    static NSArray *images = nil;
    if (images == nil){
        images = @[[UIImage imageNamed:@"cricket_ball"],[UIImage imageNamed:@"Football_Ball"],[UIImage imageNamed:@"football"],[UIImage imageNamed:@"Soccer_Ball"]];
    }
    return images;

}
                                                       
- (UIImage *) randomImage{
    return [self allImages][arc4random_uniform([self allImages].count)];
}


@end
