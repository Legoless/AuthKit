#import "AKCore.h"

@interface AKCrashlyticsClient : AKClient

@property (nonatomic, strong) NSString* accessToken;
@property (nonatomic, readonly) NSString* developerToken;

- (id)initWithDeveloperToken:(NSString *)developerToken;

- (id)initWithDeveloperToken:(NSString *)developerToken accessToken:(NSString *)accessToken;

/*- (void)applicationsForOrganization:(CRMOrganization *)organization;
- (void)organizationsWithSuccess;

- (void)buildsForApplication:(CRMApplication *)application;
//- (void)setReportCollectionForBuild:(CLBuild *)build enabled:(BOOL)enabled;
- (void)issuesForApplication:(CRMApplication *)application;
- (void)latestIncidentForIssue:(CRMIssue *)issue;
- (void)detailsForIssue:(CRMIssue *)issue;
//- (void)setResolved:(BOOL)resolved forIssue:(CLIssue *)issue;
 */

@end
