//
//  CCBNodeTempLoader.h
//  cpp
//
//  Created by Higgx on 11/4/13.
//
//

#ifndef cpp_CCBNodeTempLoader_h
#define cpp_CCBNodeTempLoader_h

#include "CCBNodeTemp.h"

class CCBReader;

class CCBNodeTempLoader : public cocos2d::extension::CCNodeLoader
{
public:
    CCB_STATIC_NEW_AUTORELEASE_OBJECT_METHOD(CCBNodeTempLoader, loader);
    
protected:
    CCB_VIRTUAL_NEW_AUTORELEASE_CREATECCNODE_METHOD(CCBNodeTemp);
};
#endif
