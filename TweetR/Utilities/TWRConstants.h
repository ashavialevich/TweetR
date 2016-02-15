#import <Foundation/Foundation.h>

/**
 * Header and implementation file that is used to store the constants that are reused accross the application in a
 * manner that allows proper type checking that you would not get from standard #define.
 */
/**
 * NSString constant that represents a regular expression for an email address.  The email can consist of valid email
 * characters, followed by @ then at least one host value (subhosts are supported), followed by a period, and then the
 * domain, which must be at least 2 characters.
 */
FOUNDATION_EXPORT NSString *const TWR_EMAIL_REG_EX;
