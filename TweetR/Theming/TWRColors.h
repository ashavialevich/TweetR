#ifndef TWRColors_h
#define TWRColors_h

#define TWRUIColorFromRGBWithAlpha(rgbValue, transparency)                                                             \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
                     blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
                    alpha:transparency]

#define TWRUIColorFromRGB(rgbValue)                                                                                    \
    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0                                               \
                    green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0                                                  \
                     blue:((float)(rgbValue & 0xFF)) / 255.0                                                           \
                    alpha:1.0]

#define TWR_TWITTER_BLUE 0x1DA1F2
#define TWR_FORM_FIELD_ERROR 0xF7E8E9

#endif