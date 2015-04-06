//
//  ViewController.m
//  FlickrBugs
//
//  Created by Geppy Parziale on 10/21/14.
//  Copyright (c) 2014 iNVASIVECODE, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import "CustomCell.h"
#import "Cache.h"
#import "DetailViewController.h"


#define kFlickrKey      @"822a8fe25a60ace9b28a15409f0fdf09"
#define kSearchWord     @"landscape"
#define kTotalItems     200

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSURLSession *urlSession;
@property (nonatomic, strong) NSURLSessionDataTask *downloadTask;
@property (nonatomic, copy) NSArray *photoCollection;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    self.urlSession = [NSURLSession sessionWithConfiguration:config];
}

- (IBAction)updateData:(id)sender
{
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&text=%@&has_geo=1&per_page=%d&format=json&nojsoncallback=1", kFlickrKey, kSearchWord, kTotalItems];


    NSURL *url = [NSURL URLWithString:urlString];

    self.downloadTask = [self.urlSession dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (data.length > 0) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *photoList = dictionary[@"photos"][@"photo"];

            NSMutableArray *photos = [[NSMutableArray alloc] initWithCapacity:[photoList count]];
            for (NSDictionary *element in photoList) {

                Photo *photo = [[Photo alloc] init];
                photo.farm = [element[@"farm"] intValue];
                photo.server = [element[@"server"] intValue];
                photo.secret = element[@"secret"];
                photo.photoID = [element[@"id"] longLongValue];
                photo.title = element[@"title"];
                photo.thumbanailUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://farm%ld.staticflickr.com/%ld/%lld_%@_%@.jpg", (long)photo.farm, (long)photo.server, photo.photoID, photo.secret, @"m"]];
                photo.fullImageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://farm%ld.staticflickr.com/%ld/%lld_%@_%@.jpg", (long)photo.farm, (long)photo.server, photo.photoID, photo.secret, @"b"]];
                photo.locationUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.geo.getLocation&api_key=%@&photo_id=%lld&format=json", kFlickrKey, photo.photoID]];

                [photos addObject:photo];
            }

            self.photoCollection = photos;

            dispatch_async(dispatch_get_main_queue(), ^{
                [self.collectionView reloadData];
            });
        }
    }];
    
    [self.downloadTask resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.photoCollection.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CustomCell *cell = (CustomCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"com.invasivecode.cell" forIndexPath:indexPath];

    Photo *photo = self.photoCollection[indexPath.item];
    NSURL *imageUrl = photo.thumbanailUrl;

//    NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
//    UIImage *image = [UIImage imageWithData:imageData];
//    [[cell photoImageView] setImage:image];

//    if (self.collectionView.dragging == NO && self.collectionView.decelerating == NO) {


    //////////////////////////////////////////
    //// THIS IS THE IMPORTANT PIECE  ///////
    /////////////////////////////////////////
        static NSCache *cache = nil;
        if (cache == nil) {
            cache = [[NSCache alloc] init];
        }
    
        UIImage *image = [cache objectForKey:imageUrl];
        if (image) {
            [[cell photoImageView] setImage:image];
        }
        else {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
                NSData *imageData = [NSData dataWithContentsOfURL:imageUrl];
                UIImage *image = [UIImage imageWithData:imageData];
                [cache setObject:image forKey:imageUrl];

                dispatch_async(dispatch_get_main_queue(), ^{
                    [[cell photoImageView] setImage:image];
                });
            });
        }

    ///////////////////////////////////////////
    //////////////////////////////////////////
    //////////////////////////////////////////

//    }

    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    CustomCell *cell = (CustomCell *)sender;
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if ([segue.identifier isEqualToString:@"toDetailViewController"]) {
        Photo *photo = self.photoCollection[indexPath.item];
        NSURL *imageUrl = photo.fullImageUrl;
        DetailViewController *vc = (DetailViewController *)segue.destinationViewController;
        vc.imageUrl = imageUrl;
    }
}


@end
