// CocoaUPnP by A&R Cambridge Ltd, http://www.arcam.co.uk
// Copyright 2015 Arcam. See LICENSE file.

#import "UPPContentDirectoryService.h"
#import "UPPConstants.h"
#import "UPPSessionManager.h"
#import "NetworkTestHelpers.h"

SpecBegin(UPPContentDirectoryService)

describe(@"UPPContentDirectoryService", ^{
    
    __block UPPContentDirectoryService *service;
    __block id sessionManager;
    __block NSString *url;
    
    beforeEach(^{
        service = [[UPPContentDirectoryService alloc] init];
        service.nameSpace = @"urn:schemas-upnp-org:service:ContentDirectory:1";
        
        sessionManager = OCMClassMock([UPPSessionManager class]);
        service.sessionManager = sessionManager;
        
        url = @"http://127.0.0.1/ctrl";
        NSURL *controlURL = [NSURL URLWithString:url];
        service.controlURL = controlURL;
    });
    
    describe(@"when getting search capabilities", ^{
        it(@"should send required parameters", ^{
            NSDictionary *expectedParams = @{ UPPSOAPActionKey: @"GetSearchCapabilities",
                                              UPPNameSpaceKey: service.nameSpace };
            
            VerifyGetPostWithParams(expectedParams, sessionManager, url);
            
            [service searchCapabilitiesWithCompletion:^(NSDictionary *response, NSError *error) {
                expect(response[@"Hello"]).to.equal(@"World");
                expect(error).to.beNil();
            }];
            
            [sessionManager verify];
        });
    });
    
    describe(@"when getting sort capabilities", ^{
        it(@"should send required parameters", ^{
            NSDictionary *expectedParams = @{ UPPSOAPActionKey: @"GetSortCapabilities",
                                              UPPNameSpaceKey: service.nameSpace };
            
            VerifyGetPostWithParams(expectedParams, sessionManager, url);
            
            [service sortCapabilitiesWithCompletion:^(NSDictionary *response, NSError *error) {
                expect(response[@"Hello"]).to.equal(@"World");
                expect(error).to.beNil();
            }];
            
            [sessionManager verify];
        });
    });
    
    describe(@"when getting system update id", ^{
        it(@"should send required parameters", ^{
            NSDictionary *expectedParams = @{ UPPSOAPActionKey: @"GetSystemUpdateID",
                                              UPPNameSpaceKey: service.nameSpace };
            
            VerifyGetPostWithParams(expectedParams, sessionManager, url);
            
            [service systemUpdateIDWithCompletion:^(NSDictionary *response, NSError *error) {
                expect(response[@"Hello"]).to.equal(@"World");
                expect(error).to.beNil();
            }];
            
            [sessionManager verify];
        });
    });
    
    describe(@"when browsing directory", ^{
        it(@"should send required parameters", ^{
            NSString *objectID = @"0";
            NSString *browseFlag = @"BrowseDirectChildren";
            NSString *filter = @"*";
            NSNumber *startingIndex = @0;
            NSNumber *requestedCount = @20;
            NSString *sortCriteria = @"+dc:title";
            
            NSDictionary *params = @{ @"ObjectID": objectID,
                                      @"BrowseFlag": browseFlag,
                                      @"Filter": filter,
                                      @"StartingIndex": startingIndex,
                                      @"RequestedCount": requestedCount,
                                      @"SortCriteria": sortCriteria };
            
            NSDictionary *expectedParams = @{ UPPSOAPActionKey: @"Browse",
                                              UPPNameSpaceKey: service.nameSpace,
                                              UPPParametersKey: params };
            
            VerifyGetPostWithParams(expectedParams, sessionManager, url);
            
            [service browseWithObjectID:objectID browseFlag:BrowseDirectChildren filter:filter startingIndex:startingIndex requestedCount:requestedCount sortCritera:sortCriteria completion:^(NSDictionary *response, NSError *error) {
                expect(response).toNot.beNil();
                expect(error).to.beNil();
            }];
            
            [sessionManager verify];
        });
        
        it(@"should set sane defaults", ^{
            NSDictionary *params = @{ @"ObjectID": @0,
                                      @"BrowseFlag": @"BrowseMetadata",
                                      @"Filter": @"*",
                                      @"StartingIndex": @0,
                                      @"RequestedCount": @20,
                                      @"SortCriteria": @"+dc:title" };
            
            NSDictionary *expectedParams = @{ UPPSOAPActionKey: @"Browse",
                                              UPPNameSpaceKey: service.nameSpace,
                                              UPPParametersKey: params };
            
            VerifyGetPostWithParams(expectedParams, sessionManager, url);
            
            [service browseWithObjectID:nil browseFlag:BrowseMetadata filter:nil startingIndex:nil requestedCount:nil sortCritera:nil completion:^(NSDictionary *response, NSError *error) {}];
            
            [sessionManager verify];
        });
    });
    
    describe(@"when searching directory", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when creating object", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when destroying object", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when updating object", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when importing resource", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when exporting resource", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when stopping transfer resource", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when getting transfer progress", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when deleting resource", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
    describe(@"when creating reference", ^{
        xit(@"should send required parameters", ^{
        });
    });
    
});

SpecEnd