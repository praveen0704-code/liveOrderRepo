//
//  HttpMacros.swift

//
//  Created by admin on 24/10/18.
//  Copyright © 2018 Andal Priyadharshini K. All rights reserved.
//

import Foundation
import KeychainSwift
import UIKit



var LIVE_ORDER_HOSTURL = "https://dev-lc.livc.in"

//var LIVE_ORDER_HOSTURL = "https://uat-lc.livc.in"
//var LIVE_ORDER_HOSTURL = "https://qa-lc.livc.in"

var CSQUARE_DEMO_URL = "https://qa-tg-bot-api.livetrack.in/csquare/send-demo-email"
var DEMO_URL = "https://qa-lc.livc.in/c2/lc/ms/cust/firm/demo"
var LOGIN_URL = "/c2/lc/ms/cust/na/login"
var REGISTER_URL = "/c2/lc/ms/cust/na/register"
var OTP_URL = "/lc/ms/c2/otp/send/"
var VERIFY_OTP_URL = "/lc/ms/c2/otp/verify"
var STATE_LIST_URL = "/c2/lc/ms/mst/g/state"
var CITY_LIST_URL = "/c2/lc/ms/mst/g/city/"
var AREA_LIST_URL = "/c2/lc/ms/mst/g/area/"
var MOBILE_EXIST_URL = "/c2/lc/ms/cust/na/check"
var REGISTER_FIRM_DETAIL_URl = "/c2/lc/ms/cust/firm/detail"
var FIRM_FOR_URL = "/c2/lc/ms/cust/firm/detail"
var OTP_SEND_URL = "/lc/ms/c2/otp/send/"
var PINCODE_WISE_STATE_SEARCH = "/c2/lc/ms/cust/na/address"
var FORGET_PASSWORD_URL = "/lc/ms/c2/srv/l/password/forgot"
var FIRM_UPDATE_URL = "/c2/lc/ms/cust/firm/update"

//MARK: - Landingpage Urls
var BANNER_URL = "/c2/lc/ms/mst/g/banner"
var TOPMOST_ORDER_URL = "/c2/lc/ms/mst/item/top"
var NEW_LAUNCH_ITEM_URL = "/c2/lc/ms/mst/item/new"
var SHOP_MFG_URL = "/c2/lc/ms/mst/head/mfg"
var LIMITED_OFFERS_URL = "/c2/lc/ms/mst/seller/fetch-offers"
var SHORT_BOOK_COUNT_URL = "/c2/lc/ms/ord/l/sb/count"
var WATCH_LIST_COUNT_URL = "/c2/lc/ms/ord/l/wl/count"
var NOTIFICATION_COUNT_URL = "/c2/lc/ms/cust/notification/count"
var CART_COUNT_MODEL_URL = "/c2/lc/ms/ord/l/cart/count"
var SHORTBOOK_ITEM_CODE_URL = "/c2/lc/ms/ord/l/sb/itemCodes"
var WISHLIST_ITEM_CODE_URL = "/c2/lc/ms/ord/l/wl/itemCodes"
//MARK: - Pdp Page Urls
var PDP_URL = "/c2/lc/ms/mst/item/pdp"
var PRODUCT_WISE_SELLER_DETAILS_URL = "/c2/lc/ms/mst/search/l/getSellerByItemCode"
//var ITEM_BY_SELLER_CODE_URL = "/c2/lc/ms/mst/search/l/itemsBySellerCode"
//var ITEM_BY_MFC_CODE_URL = "/c2/lc/ms/mst/search/l/itemsByMfcCode"
var ITEM_BY_MOLECULES_FILTTER_URL = "/c2/lc/ms/mst/filter/l/moleculeFilter"
var ITEM_BY_TOP_OFFER_FILTTER_URL = "/c2/lc/ms/mst/filter/l/topMostOrderFilter"
var ITEM_BY_NEW_LAUNCH_FILTTER_URL = "/c2/lc/ms/mst/filter/l/newLaunchFilter"
var ITEM_BY_SELLER_CODE_URL = "/c2/lc/ms/mst/filter/l/preferredSellerFilter"
var ITEM_BY_MFC_CODE_URL = "/c2/lc/ms/mst/filter/l/shopByMfcFilter"
var ITEM_BY_MOL_CODE_URL = "/c2/lc/ms/mst/search/l/itemsByMoleculeCode"
var ITEM_BY_CATEGORIES_ITEMS_URL = "/c2/lc/ms/mst/filter/l/categoryFilter"
var ADD_TO_CART_URL = "/c2/lc/ms/ord/l/cart/addItem"
var SEARCH_PRODUCT_DROPDOWN_URL = "/c2/lc/ms/mst/search/l/prd"
var SEARCH_PRODUCT_DROPDOWN_MOLECULE = "/c2/lc/ms/mst/mol/list"
var SEARCH_PRODUCT_DROPDOWN_SELLER = "/c2/lc/ms/mst/search/l/seller"
var SEARCH_PRODUCT_DROPDOWN_MFG = "/c2/lc/ms/mst/search/l/mfc"
var ADD_TO_WISHLIST_URL = "/c2/lc/ms/ord/l/wl/addToWatchlists"
var ADD_TO_SHOTBOOK_URL = "/c2/lc/ms/ord/l/sb/add"

//:- PLP FILTTER URLS
var MANUFACTURE_FILTTER_URL = "/c2/lc/ms/mst/filter/l/topMostOrderMfc"
var BRAND_FILTTER_URL = "/c2/lc/ms/mst/filter/l/topMostOrderBrand"
var SELLER_FILTTER_URL = "/c2/lc/ms/mst/filter/l/topMostOrderSeller"

var REMOVE_FROM_SHORTBOOK_URL = "/c2/lc/ms/ord/l/sb/remove"
var REMOVE_FROM_WISHLIST_URL = "/c2/lc/ms/ord/l/wl/removeFromWatchlist"
var SELLER_WISE_PRODUCT_LIST = "/c2/lc/ms/mst/search/l/itemsBySellerCode"
var CART_LIST_URL = "/c2/lc/ms/ord/l/cart/branch/cart"
var CATEGORY_LIST_URL = "/c2/lc/ms/mst/g/category"
var FIRM_PROFILE_URL = "/c2/lc/ms/cust/firm/profile"
var SELLER_INNSPIRED_BY_URL = "/c2/lc/ms/mst/seller/preferred"
var GST_TYPE_URL = "/c2/lc/ms/mst/g/gst"

//MARK: - SHORTBOOK list urls
var SHORTBOOK_LIST_URL = "/c2/lc/ms/ord/l/sb/list"

//MARK : WISHLIST list urls
var WISHLIST_LIST_URL = "/c2/lc/ms/ord/l/wl/getWatchListLists"
var ORDER_TO_SELLER_LIST_URL = "/c2/lc/ms/cust/seller/list"
var SEARCH_UNMAPPED_LIST_URL = "/c2/lc/ms/cust/seller/search/unmappedseller"
var MAPPED_SELLER_LIST = "/c2/lc/ms/cust/seller/mapped/seller"

// MARK: - ORDER TO SELLER FILTTER VC URLS
var SEARCH_STATE_LIST_URL = "/c2/lc/ms/mst/g/state/search"
var SEARCH_CITY_LIST_URL = "/c2/lc/ms/mst/g/city/search"
var SEARCH_AREA_LIST_URL = "/c2/lc/ms/mst/g/area/search"
var OTOS_PRIORITY_URL = "/c2/lc/ms/cust/seller/update/priority"

//MARK: - Search By City Stare Area
var SEARCH_BY_CITY_STATE_AREA_URL = "/c2/lc/ms/cust/seller/search/unmappedseller/cas"
var ADD_A_SELLER_URL = "/c2/lc/ms/cust/seller/getsellerinfo"

//MARK: - PROFILE URLS
var GET_BRANCH_LIST_URL = "/c2/lc/ms/cust/firm/getbranchlist"
var SET_DEFAULT_BRANCH = "/c2/lc/ms/cust/firm/setdefaultbranch"
var GET_BRANCH_DETAILS = "/c2/lc/ms/cust/firm/getbranchdetails"

//MARK: - Order History Url
var ORDER_HISTORY_URL = "/c2/lc/ms/ord/l/ord/orderHistory"

//MARK: - Comain Store
var COMAIN_STORE_LIST_URL = "/c2/lc/ms/cust/na/store/combine/list"
var COMAIN_STORE_NS_URL = "/c2/lc/ms/cust/na/combine/store"
var SAVE_COMBAIED_STORE_AURTH = "/c2/lc/ms/cust/firm/save/uncombined/stores"
var SAVE_COMBAIED_STORE_UNAURTH = "/c2/lc/ms/cust/na/save/uncombined/stores"
var COMBAIN_FIRM_UPDATE_STORE = "/c2/lc/ms/cust/firm/update/store"
var COMBINE_STORE_AUTH = "/c2/lc/ms/cust/firm/combine/store"

//MARK: - Recent Search
var RESET_SEARCH_URL = "/c2/lc/ms/mst/search/l/history/"
//MARK: - Get User
var GET_USER_URL = "/c2/lc/ms/cust/user/getUser"
//MARK: - FeedBack
var UPLOAD_IMG_URL = "/lc/ms/c2/blob/upload"

//MARK: - Total Count URl
var SHOPBYMANIFACTURE_COUNT_URL = "/c2/lc/ms/mst/count/preferredSellerFilter"
var TOPMOSTORDER_COUNT_URL = "/c2/lc/ms/mst/count/topMostOrderFilter"
var SHOPBYMFC_COUNT_URL = "/c2/lc/ms/mst/count/shopByMfcFilter"
var CATEORIES_COUNT_URL = "/c2/lc/ms/mst/count/categoryFilter"
var IMG_UPLOAD_URL = "/lc/ms/c2/blob/upload"
var DISTRIBUTER_LIST_URL = "/c2/lc/ms/cust/feedback/distributor/list"
var SAVE_FEEDBACK_URL = "/c2/lc/ms/cust/feedback/saveFeedback"
var DELETE_CART_URL = "/c2/lc/ms/ord/l/cart/deleteItem"

