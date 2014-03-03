//
//  ISSViewBuilder.m
//  Part of InterfaCSS - http://www.github.com/tolo/InterfaCSS
//
//  Created by Tobias Löfstrand on 2012-12-07.
//  Copyright (c) 2012 Leafnode AB.
//  License: MIT (http://www.github.com/tolo/InterfaCSS/LICENSE)
//


#import "ISSViewBuilder.h"

#import "UIView+InterfaCSS.h"
#import "NSString+ISSStringAdditions.h"
#import "ISSViewHierarchyParser.h"


id InterfaCSS_BuildView(NSString* styleClassName, SubViewBlock subViewBlock) {
    return [ISSViewBuilder viewWithStyle:styleClassName andSubViews:subViewBlock];
}

id InterfaCSS_BuildLeafView(NSString* styleClassName) {
    return [ISSViewBuilder viewWithStyle:styleClassName];
}

id InterfaCSS_SetupView(UIView* theView, NSString* styleClassName, SubViewBlock subViewBlock) {
    return [ISSViewBuilder setupView:theView withStyleClass:styleClassName andSubViews:subViewBlock];
}

id InterfaCSS_SetupLeafView(UIView* theView, NSString* styleClassName) {
    return [ISSViewBuilder setupView:theView withStyleClass:styleClassName];
}


@implementation ISSViewBuilder


#pragma mark - View setup

+ (id) setupView:(UIView*)theView withStyleClass:(NSString*)styleClassName andSubViews:(SubViewBlock)subViewBlock andPropertyOwner:(id)propertyOwner {
    if( styleClassName ) {
        static NSCharacterSet* characterSet = nil;
        if( !characterSet ) characterSet = [NSCharacterSet characterSetWithCharactersInString:@" ,"];
        NSArray* styles = [styleClassName trimmedSplitWithSet:characterSet];
        if( styles.count > 1 ) {
            for(NSString* style in styles) [theView addStyleClass:style];
        }
        else theView.styleClass = styleClassName;
    }
    
    if( subViewBlock ) {
        NSArray* subViews = subViewBlock();
        for(UIView* subView in subViews) [theView addSubview:subView];
    }
    return theView;
}

+ (id) setupView:(UIView*)theView withStyleClass:(NSString*)styleClassName andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:theView withStyleClass:styleClassName andSubViews:subViewBlock andPropertyOwner:nil];
}

+ (id) setupView:(UIView*)theView withStyleClass:(NSString*)styleClassName {
    return [self setupView:theView withStyleClass:styleClassName andSubViews:nil andPropertyOwner:nil];
}


#pragma mark - Containers

+ (ISSRootView*) rootViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[ISSRootView alloc] init] withStyleClass:styleClass];
}

+ (ISSRootView*) rootViewWithStyle:(NSString*)styleClass andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[ISSRootView alloc] init] withStyleClass:styleClass andSubViews:subViewBlock];
}

+ (ISSRootView*) loadViewHierarchyFromMainBundleFile:(NSString*)fileName withFileOwner:(id)fileOwner {
    NSURL* url = [[NSBundle mainBundle] URLForResource:fileName withExtension:nil];
    NSData* fileData = [NSData dataWithContentsOfURL:url];
    return [ISSViewHierarchyParser parseViewHierarchyFromData:fileData withFileOwner:fileOwner];
}

+ (ISSRootView*) loadViewHierarchyFromFile:(NSString*)fileName fileOwner:(id)fileOwner {
    NSData* fileData = [NSData dataWithContentsOfFile:fileName];
    return [ISSViewHierarchyParser parseViewHierarchyFromData:fileData withFileOwner:fileOwner];
}

+ (UIView*) viewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIView alloc] init] withStyleClass:styleClass];
}

+ (UIView*) viewWithStyle:(NSString*)styleClass andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[UIView alloc] init] withStyleClass:styleClass andSubViews:subViewBlock];
}

+ (UICollectionView*) collectionViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UICollectionView alloc] init] withStyleClass:styleClass];
}

+ (UICollectionView*) collectionViewWithStyle:(NSString*)styleClass andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[UICollectionView alloc] init] withStyleClass:styleClass andSubViews:subViewBlock];
}

+ (UIImageView*) imageViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIImageView alloc] init] withStyleClass:styleClass];
}

+ (UIImageView*) imageViewWithStyle:(NSString*)styleClass andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[UIImageView alloc] init] withStyleClass:styleClass andSubViews:subViewBlock];
}

+ (UIScrollView*) scrollViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIScrollView alloc] init] withStyleClass:styleClass];
}

+ (UIScrollView*) scrollViewWithStyle:(NSString*)styleClass andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[UIScrollView alloc] init] withStyleClass:styleClass andSubViews:subViewBlock];
}

+ (UITableView*) tableViewWithStyle:(NSString*)styleClass andTableViewStyle:(UITableViewStyle)tableViewStyle {
    return [self setupView:[[UITableView alloc] initWithFrame:CGRectZero style:tableViewStyle] withStyleClass:styleClass];
}

+ (UITableView*) tableViewWithStyle:(NSString*)styleClass andTableViewStyle:(UITableViewStyle)tableViewStyle andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[UITableView alloc] initWithFrame:CGRectZero style:tableViewStyle] withStyleClass:styleClass andSubViews:subViewBlock];
}

+ (UIWebView*) webViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIWebView alloc] init] withStyleClass:styleClass];
}

+ (UIWebView*) webViewWithStyle:(NSString*)styleClass andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[UIWebView alloc] init] withStyleClass:styleClass andSubViews:subViewBlock];
}


#pragma mark - Components

+ (UIActivityIndicatorView*) activityViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIActivityIndicatorView alloc] init] withStyleClass:styleClass];
}

+ (UIButton*) buttonWithStyle:(NSString*)styleClass {
    return [self setupView:[UIButton buttonWithType:UIButtonTypeCustom] withStyleClass:styleClass];
}

+ (UIButton*) buttonWithStyle:(NSString*)styleClass andButtonType:(UIButtonType)buttonType {
    return [self setupView:[UIButton buttonWithType:buttonType] withStyleClass:styleClass];
}

+ (UILabel*) labelWithStyle:(NSString*)styleClass {
    return [self setupView:[[UILabel alloc] init] withStyleClass:styleClass];
}

+ (UIProgressView*) progressViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIProgressView alloc] init] withStyleClass:styleClass];
}

+ (UISlider*) sliderWithStyle:(NSString*)styleClass {
    return [self setupView:[[UISlider alloc] init] withStyleClass:styleClass];
}

+ (UIStepper*) stepperWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIStepper alloc] init] withStyleClass:styleClass];
}

+ (UISwitch*) switchWithStyle:(NSString*)styleClass {
    return [self setupView:[[UIStepper alloc] init] withStyleClass:styleClass];
}

+ (UITextField*) textFieldWithStyle:(NSString*)styleClass {
    return [self setupView:[[UITextField alloc] init] withStyleClass:styleClass];
}

+ (UITextView*) textViewWithStyle:(NSString*)styleClass {
    return [self setupView:[[UITextView alloc] init] withStyleClass:styleClass];
}

+ (UITextField*) textFieldWithStyle:(NSString*)styleClass andSubViews:(SubViewBlock)subViewBlock {
    return [self setupView:[[UITextField alloc] init] withStyleClass:styleClass andSubViews:subViewBlock];
}


+ (UITableViewCell*) tableViewCellWithStyle:(NSString*)styleClass andReuseIdentifier:(NSString*)reuseIdentifier {
    return [self setupView:[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier] withStyleClass:styleClass];
}

+ (UITableViewCell*) tableViewCellWithStyle:(NSString*)styleClass andCellStyle:(UITableViewCellStyle)cellStyle andReuseIdentifier:(NSString*)reuseIdentifier {
    return [self setupView:[[UITableViewCell alloc] initWithStyle:cellStyle reuseIdentifier:reuseIdentifier] withStyleClass:styleClass];
}

@end
