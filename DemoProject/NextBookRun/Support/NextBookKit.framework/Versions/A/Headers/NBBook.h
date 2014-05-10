//
//  NBBook.h
//  NextBook
//
//  Created by Chen Yonghui on 12/25/12.
//  Copyright (c) 2012 Shanghai TinyNetwork. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class NBChapter;
@class NBiBooksArchive;
@class NBBook;

typedef void(^NBBookLoadingProcessing)(NSInteger idx, NSInteger total);
typedef void(^NBBookLoadingCompletion)(NBBook *book);

/*!
 *  @header NBBook.h
 *  @abstract Represents a book.
 */

/*!
 *  @class NBBook
 *  @abstract Represents a book.
 *
 *  @discussion
 *  
 *
 */

@interface NBBook : NSObject

/*!
 *  @abstract The book's language
 *  @property language
 *
 *  @discussion
 *  Returns the book's language
 */
@property(readonly, copy, nonatomic) NSString *language;
@property(readonly, strong, nonatomic) NSDictionary *bookSummary;

/*!
 *  @abstract The book's created date
 *  @property timestamp
 *
 *  @discussion
 *  Returns book's created date. the date book been export.
 */
@property(readonly, copy, nonatomic) NSDate *timestamp;

/*!
 *  @abstract the book's required version
 *  @property requiredVersion
 *
 *  @discussion
 *  Returns required version to open this book
 */
@property(readonly, copy, nonatomic) NSString *requiredVersion;

/*!
 *  @abstract the book's authored version
 *  @property authoredVersion
 *
 *  @discussion
 *  Returns iBooks Authore version that create this book
 */
@property(readonly, copy, nonatomic) NSString *authoredVersion;

/*!
 *  @abstract The book's uniquifier
 *  @property uniquifier
 *
 *  @discussion
 *  Returns book's unique identifier. An UUID.
 */
@property(readonly, copy, nonatomic) NSString *uniquifier;

/*!
 *  @abstract The book's ISBN
 *  @property isbn
 *
 *  @discussion
 *  Returns book's ISBN. Current Not Implemented.
 */
@property(readonly, copy, nonatomic) NSString *isbn;

/*!
 *  @abstract The book's genre
 *  @property genre
 *
 *  @discussion
 *  Returns book's genre. Current Not Implemented.
 */
@property(readonly, copy, nonatomic) NSString *genre;

/*!
 *  @abstract The book's author
 *  @property bookAuthor
 *
 *  @discussion
 *  Returns book's author
 */
@property(readonly, copy, nonatomic) NSString *bookAuthor;

/*!
 *  @abstract The application name that create this book
 *  @property publisherName
 *
 *  @discussion
 *  Returns the application name that create this book. like "iBooks Author 2.0"
 */
@property(readonly, copy, nonatomic) NSString *publisherName;

/*!
 *  @abstract The book's subtitle
 *  @property bookSubtitle
 *
 *  @discussion
 *  Returns book's subTitle. Current Not Implemented.
 */
@property(readonly, copy, nonatomic) NSString *bookSubtitle;

/*!
 *  @abstract The book's title
 *  @property bookTitle
 *
 *  @discussion
 *  Returns book's title.
 */
@property(readonly, copy, nonatomic) NSString *bookTitle;

/*!
 *  @abstract The book's version
 *  @property bookVersionString
 *
 *  @discussion
 *  Returns book's version string.
 */
@property(readonly, copy, nonatomic) NSString *bookVersionString;

/*!
 *  @abstract The book's cover image
 *  @property coverImage
 *
 *  @discussion
 *  Returns book's cover image
 */
@property (readonly, strong, nonatomic) UIImage *coverImage;

/*!
 *  @abstract Automatically hyphenate
 *  @property autoHyphenate
 *
 *  @discussion
 *  Indicate if book automatically hyphenate words.
 */
@property(readonly, assign) BOOL autoHyphenate;

/*!
 *  @abstract The book's orientation
 *  @property orientationMask
 *
 *  @discussion
 *  Returns supported orientation.
 */
@property (nonatomic, assign,readonly) UIInterfaceOrientationMask orientationMask;

/*!
 *  @abstract The book's introMedia's path
 *  @property introMediaPath
 *
 *  @discussion
 *  Returns path of intro media.
 */
@property (readonly, copy, nonatomic) NSString *introMediaPath;

- (id)initWithContentsOfFile:(NSString *)filePath onProcessing:(NBBookLoadingProcessing)processing onCompletion:(NBBookLoadingCompletion)completion;
+ (instancetype)bookWithContentsOfFile:(NSString *)filePath onProcessing:(NBBookLoadingProcessing)processing onCompletion:(NBBookLoadingCompletion)completion;

/*!
 *  @abstract Initializes a book with the contents of the location specified by a given path.
 *
 *  @discussion
 *  the path can be
 *      * a file that indicate an iBooks file
 *      * a directory that indicate unzipped iBooks file.
 *  If you pass in an iBooks file path, you needs call prepareForOpenOnProcessing:onCompletion: before open it.
 *
 *  @see prepareForOpenOnProcessing:onCompletion:
 *  @see bookWithContentsOfFile:

 */
- (id)initWithContentsOfFile:(NSString *)filePath;
+ (instancetype)bookWithContentsOfFile:(NSString *)filePath;
- (void)prepareForOpenOnProcessing:(NBBookLoadingProcessing)processing onCompletion:(NBBookLoadingCompletion)completion;

@property (readonly, nonatomic, assign, getter = isReadyForOpen) BOOL readyForOpen;

@property (nonatomic, readonly) NSString *bookPath;
@property (nonatomic, strong,readonly) NBiBooksArchive *bookArchive;

// Content
@property (strong) NSArray *chapters;
- (NBChapter *)chapterAtIndex:(NSInteger)index;
- (NSInteger)numberOfChapters;
- (NSInteger)numberOfSectionsInChapter:(NSInteger)chapter;
- (NSInteger)numberOfPagesInSection:(NSInteger)section chapter:(NSInteger)chapter;

- (int)absolutePageNumberForIndexPath:(NSIndexPath *)indexPath;


// TOC
@property (assign) BOOL showPageNumbers;
@property (copy) NSString *tocHeaderImagePath;

// Read Position
- (NSIndexPath *)recordedReadPosition;
- (void)recordReadPosition:(NSIndexPath *)indexPath;

@property (nonatomic, strong) NSDictionary *additionDictionary;

@end

@interface NSIndexPath (NBBookLib)
+ (NSIndexPath *)indexPathForPage:(NSInteger)page inSection:(NSInteger)section inChapter:(NSInteger)chapter;

@property(nonatomic,readonly) NSInteger bookChapter;
@property(nonatomic,readonly) NSInteger bookSection;
@property(nonatomic,readonly) NSInteger bookPage;

@end
