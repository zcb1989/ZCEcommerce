//
//  ZCDefines.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/12.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#ifndef ZCDefines_h
#define ZCDefines_h

/**
 *  ZC_EXTERN user this as extern
 *
 *  @param ZC_EXTERN
 *
 *  @return
 */
#if !defined(ZC_EXTERN)
#  if defined(__cplusplus)
#    define ZC_EXTERN extern "C"
#  else
#    define ZC_EXTERN extern
#  endif
#endif

#if !__has_feature(objc_arc)

/**
 *  safe release
 *
 *  @param __REF <#__REF description#>
 *
 *  @return <#return value description#>
 */
#undef ZC_RELEASE_SAFELY
#define ZC_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF)) \
{\
CFRelease(__REF);\
__REF = nil;\
}\
}
/**
 *  View safe release
 *
 *  @param __REF <#__REF description#>
 *
 *  @return <#return value description#>
 */
#undef ZCVIEW_RELEASE_SAFELY
#define ZCVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
CFRelease(__REF);\
__REF = nil;\
}\
}
/**
 *  timer release
 *
 *  @param __TIMER <#__TIMER description#>
 *
 *  @return <#return value description#>
 */
#undef ZC_INVALIDATE_TIMER
#define ZC_INVALIDATE_TIMER(__TIMER)\
{\
[__TIMER invalidate];\
[__TIMER release];\
__TIMER = nil;\
}

#else
/**
 *  safe release
 *
 *  @param __REF <#__REF description#>
 *
 *  @return <#return value description#>
 */
#undef ZC_RELEASE_SAFELY
#define ZC_RELEASE_SAFELY(__REF) \
{\
if(nil != (__REF)) \
{\
__REF = nil;\
}\
}
/**
 *  View safe release
 *
 *  @param __REF <#__REF description#>
 *
 *  @return <#return value description#>
 */
#define ZCVIEW_RELEASE_SAFELY(__REF) \
{\
if (nil != (__REF))\
{\
[__REF removeFromSuperview];\
__REF = nil;\
}\
}
/**
 *  timer release
 *
 *  @param __TIMER <#__TIMER description#>
 *
 *  @return <#return value description#>
 */
#define ZC_INVALIDATE_TIMER(__TIMER) \
{\
[__TIMER invalidate];\
__TIMER = nil;\
}
#endif


#endif /* ZCDefines_h */
