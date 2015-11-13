//
//  IPAddress.h
//  ZCBEcommerce
//
//  Created by ZCB-MAC on 15/11/12.
//  Copyright © 2015年 ZCB-MAC. All rights reserved.
//

#ifndef ZCEBuy_IPAddress_h
#define ZCEBuy_IPAddress_h


#define MAXADDRS     32

extern char *if_names[MAXADDRS];

extern char *ip_names[MAXADDRS];

extern char *hw_addrs[MAXADDRS];

extern unsigned long ip_addrs[MAXADDRS];


void InitAddresses(void);

void FreeAddresses(void);

void GetIPAddresses(void);

void GetHWAddresses(void);

#endif /* IPAddress_h */
