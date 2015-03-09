//
//  OAuthInfo.h
//  MyWeibo
//
//  Created by ChenXin on 3/5/15.
//  Copyright (c) 2015 ChenXin. All rights reserved.
// OAuth网络请求相关参数



#define AppKey @"3972601632"
#define AppSecret @"9e6df9d7c5314776204e90d9d7715289"
//Oauth登陆URL，用来获取access token
#define OAuthURL @"https://api.weibo.com/oauth2/authorize"
//获取accessToken URL
#define AccessTokenURL @"https://api.weibo.com/oauth2/access_token"
//获取所有好友微博
#define StatusDataURL @"https://api.weibo.com/2/statuses/friends_timeline.json"