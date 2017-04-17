//
//  Configuration.h
//  iBadajoz
//
//  Created by David Cordero on 18/09/13.
//  Copyright (c) 2013 David Cordero. All rights reserved.
//

#ifndef iBadajoz_Configuration_h
#define iBadajoz_Configuration_h

// General settings
#define     FEED_ENCODING               NSISOLatin1StringEncoding
#define     RATE_APP_URL                @"https://itunes.apple.com/es/app/ibadajoz/id492209827"
#define     CONTACT_SUPPORT_MAIL        @"david@corderoramirez.com"

// PATHs
#define     BASE_URL                    @"http://feeds.feedburner.com/"
#define     RSS_BASE_PATH               @""

#define     RSS_FLASH                   RSS_BASE_PATH @"aytobadajoz-noticias?format=xml"
#define     RSS_SPECIALS                RSS_BASE_PATH @"aytobadajoz-especiales?format=xml"
#define     RSS_JOBS                    RSS_BASE_PATH @"aytobadajoz-empleo?format=xml"

#define     DIRECTORIO_URL              @"http://www.aytobadajoz.es/directorio.xml"
#define     LINES_URL                   @"SECRET"
#define     PARADA_URL                  @"SECRET"
#define     BIBA_URL                    @"http://www.aytobadajoz.es/estacionesbiba.kml"
#define     HANDICAPTED_URL             @"http://www.aytobadajoz.es/mapadiscapacitados.kml"
#define     TWITTER_URL                 @"https://twitter.com/aytodebadajoz"
#define     FACEBOOK_URL                @"https://www.facebook.com/aytobadajoz"

#define     AWS_API_KEY                 @"SECRET"

// API configuration
#define     GOOGLEMAPS_APIKEY           @"SECRET"

// Storage configuration

#define     STORAGE_FLASH               @"storage_flash"
#define     STORAGE_SPECIALS            @"storage_specials"
#define     STORAGE_JOBS                @"storage_jobs"
#define     STORAGE_DIRECTORIO          @"storage_directorio"
#define     STORAGE_BUSES               @"storage_buses"
#define     STORAGE_BIBA                @"storage_biba"
#define     STORAGE_HANDICAPTED         @"storage_handicapted"

#endif

