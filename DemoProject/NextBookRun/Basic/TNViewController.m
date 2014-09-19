//
//  TNViewController.m
//  SimpleView
//
//  Created by Chen Yonghui on 11/3/13.
//  Copyright (c) 2013 Shanghai Tinynetwork. All rights reserved.
//

#import "TNViewController.h"
#import <QuartzCore/QuartzCore.h>

#import <NextBookKit/NextBookKit.h>
#import <dispatch/dispatch.h>

#import "TNSecondViewController.h"

@interface TNViewController () <UITableViewDataSource,UITableViewDelegate,NBBookNavigationControllerDelegate>
@property (nonatomic, strong) NSArray *booksURLs;
@property (nonatomic, strong) NSOperationQueue *unzipQueue;

@property (nonatomic, strong) NSIndexPath *tappedAccessoryIndexPath;

@property (nonatomic, strong) NBBook *book;

@end

@implementation TNViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
//        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
//        [nc addObserver:self selector:@selector(handle_applicationDidBecomeActive:) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        self.baseURL = [self documentDirectory];
        self.unzipQueue = [[NSOperationQueue alloc] init];

    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [NBBookLib authWithDeveloperID:@"" key:@""];

    [self reloadData];

    self.title = [self.baseURL lastPathComponent];
    UIBarButtonItem *reload = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(didPressedReloadItem:)];
//    UIBarButtonItem *test = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStyleBordered target:self action:@selector(didPressedTestItem:)];
//    self.navigationItem.rightBarButtonItems = @[self.editButtonItem,reload,test];
    self.navigationItem.rightBarButtonItems = @[reload];


    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = [NSString stringWithFormat:@"NextBookKit\nVersion: %@",[NBBookLib version]];
    label.numberOfLines = 0;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor colorWithWhite:0.600 alpha:1.000];
    [label sizeToFit];
    self.tableView.tableFooterView = label;

}

- (void)openBookAtURL:(NSURL *)url
{
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.labelText = @"opening...";
//    hud.mode = MBProgressHUDModeAnnularDeterminate;
    
    [NBBook bookWithContentsOfFile:[url path] onProcessing:^(NSInteger idx, NSInteger total) {
//        MBProgressHUD *hud = [MBProgressHUD HUDForView:self.view];
//        hud.progress = (float)idx/(float)total;
        
    } onCompletion:^(NBBook *book){
//        [MBProgressHUD hideHUDForView:self.view animated:NO];
        NBBookViewController *bookVC = [[NBBookViewController alloc] initWithBook:book];
        NSIndexPath *indexPath = [NSIndexPath indexPathForPage:0 inSection:0 inChapter:0];
        [bookVC setDisplayPageAtIndexPath:indexPath animated:YES];
        
        NBBookNavigationController *bookNav =[[NBBookNavigationController alloc] initWithContentViewController:bookVC];
        bookNav.bookNaviDelegate = self;
        
        [self presentViewController:bookNav animated:YES completion:nil];
    }];
}

- (NSURL *)documentDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (void)reloadData
{
    
//    NSNumber *value = nil;
//    [self.baseURL getResourceValue:&value forKey:NSURLIsSymbolicLinkKey error:nil];
//    BOOL isSymbolicLink = [value boolValue];
//    NSURL *url = isSymbolicLink ? [self.baseURL URLByResolvingSymlinksInPath] : self.baseURL;
    NSURL *url = self.baseURL;
    NSLog(@"list books in %@",self.baseURL);
//    NSArray *urls = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:url includingPropertiesForKeys:@[] options:0 error:nil];
    NSError *error = nil;
   NSArray *paths = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:url.path error:&error];
    
    NSMutableArray *urls = [NSMutableArray array];
    for (NSString *fileName in paths) {
        NSURL *aFile = [url URLByAppendingPathComponent:fileName];
        [urls addObject:aFile];
    }
    
//    urls = [urls sortedArrayUsingComparator:^NSComparisonResult(NSURL *obj1, NSURL *obj2) {
////        return [obj1.absoluteString localizedStandardCompare:obj2.absoluteString];
//        return [obj1.absoluteString compare:obj2.absoluteString];
//    }];
    self.booksURLs = urls;
}

- (void)handle_applicationDidBecomeActive:(NSNotification *)notify
{
    [self reloadData];
    [self.tableView reloadData];
}

- (BOOL)handleOpenURL:(NSURL *)url
{
    [self openBookAtURL:url];
    return YES;
}

- (BOOL)isBookURL:(NSURL *)url
{
    BOOL isDirectory = NO;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:url.path isDirectory:&isDirectory];
    if (exists) {
        if (isDirectory) {
            NSURL *mimetypeURL = [url URLByAppendingPathComponent:@"mimetype"];
            NSString *mimetype = [NSString stringWithContentsOfURL:mimetypeURL encoding:NSUTF8StringEncoding error:nil];
            return [mimetype isEqualToString:@"application/x-ibooks+zip"];
        }
        return YES;
    }
    return NO;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (void)didPressedReloadItem:(id)sender
{
    [self reloadData];
    [self.tableView reloadData];
}

//- (void)unzipURL:(NSURL *)url processing:(void(^)(NSInteger current, NSInteger total))processing completion:(void(^)(void))completionBlock
//{
//    NSURL *directory = [url URLByDeletingLastPathComponent];
//    NSString *name = [[url lastPathComponent] stringByDeletingPathExtension];
//    NSURL *dest = [directory URLByAppendingPathComponent:name isDirectory:YES];
//    [[NSFileManager defaultManager] createDirectoryAtURL:dest withIntermediateDirectories:YES attributes:nil error:nil];
//    
//    [self.unzipQueue addOperationWithBlock:^{
//        ZipFile *file = [[ZipFile alloc] initWithFileName:url.path mode:ZipFileModeUnzip];
//        NSArray *fileInfos = [file listFileInZipInfos];
//        
//        NSInteger total = fileInfos.count;
//        
//        [file goToFirstFileInZip];
//        NSInteger currentIndex = 0;
//        do {
//            FileInZipInfo *info = [file getCurrentFileInZipInfo];
//            NSString *fileName = [info name];
//            
//            NSURL *cacheURL = [dest URLByAppendingPathComponent:fileName];
//            
//            if (![[NSFileManager defaultManager] fileExistsAtPath:cacheURL.path]) {
//                ZipReadStream *readStream = [file readCurrentFileInZip];
//                NSMutableData *contentData = [[NSMutableData alloc] initWithLength:info.length];
//                [readStream readDataWithBuffer:contentData];
//                
//                if ([contentData length] >0) {
//                    // create directory if not exists
//                    NSString *directory = [cacheURL.path stringByDeletingLastPathComponent];
//                    BOOL directoryExists = [[NSFileManager defaultManager] fileExistsAtPath:directory];
//                    if (!directoryExists) {
//                        [[NSFileManager defaultManager] createDirectoryAtPath:directory withIntermediateDirectories:YES attributes:nil error:nil];
//                    }
//                    
//                    // write contents
//                    NSError *writeError = nil;
//                    BOOL success = [contentData writeToURL:cacheURL options:NSDataWritingAtomic error:&writeError];
//                    if (!success) {
//                        NSLog(@"unzip data to path %@ failed. error:%@",cacheURL.path,[writeError localizedDescription]);
//                    }
//                }
//                [readStream finishedReading];
//                
//            }
//            currentIndex ++;
//            if (processing) {
//                [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                    processing(currentIndex , total);
//                }];
//            }
//        } while ([file goToNextFileInZip]);
//        
//        [file close];
//        
//        if (completionBlock) {
//            [[NSOperationQueue mainQueue] addOperationWithBlock:completionBlock];
//        }
//    }];
//}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.booksURLs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSURL *url = self.booksURLs[indexPath.row];

    if (![self isBookURL:url]) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.imageView.image = [UIImage imageNamed:@"folder"];
    } else {
        BOOL directory = NO;
        [[NSFileManager defaultManager] fileExistsAtPath:url.path isDirectory:&directory];
        cell.accessoryType = directory ? UITableViewCellAccessoryNone : UITableViewCellAccessoryDetailDisclosureButton;
        cell.imageView.image = [UIImage imageNamed:@"iBooks_Document_32"];
        
    }
    cell.textLabel.text = [url lastPathComponent];
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSURL *url = self.booksURLs[indexPath.row];
    [self openBookAtURL:url];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)bookNavigationControllerDidCancel:(NBBookNavigationController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
