___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Facebook _fbc Generator",
  "categories": ["UTILITY"],
  "__wm": "VGVtcGxhdGUtQXV0aG9yX0ZhY2Vib29rRmJjR2VuZXJhdG9yLVNpbW8tQWhhdmE=",
  "description": "This variable generates a value that can be used for Facebook\u0027s _fbc cookie.",
  "containerContexts": [
    "SERVER"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "LABEL",
    "name": "label1",
    "displayName": "Use this template to generate a new \u003cstrong\u003e_fbc\u003c/strong\u003e cookie value used by Facebook. You can use the \u003ca href\u003d\"https://tagmanager.google.com/gallery/#/owners/gtm-templates-simo-ahava/templates/cookie-monster\"\u003eCookie Monster\u003c/a\u003e tag template, for example, to set the cookie in the server response.\u003cbr\u003e\u003cbr\u003e"
  },
  {
    "type": "CHECKBOX",
    "name": "returnExisting",
    "checkboxText": "Return existing _fbc cookie value if available",
    "simpleValueType": true,
    "help": "Check this box to first see if _fbc has already been set. If it has, return its value instead of generating a new one."
  },
  {
    "type": "SELECT",
    "name": "fbclidSource",
    "displayName": "Source of the fbclid value",
    "macrosInSelect": true,
    "selectItems": [
      {
        "value": "automatic",
        "displayValue": "Set automatically"
      }
    ],
    "simpleValueType": true,
    "help": "If you choose \u003cstrong\u003eSet automatically\u003c/strong\u003e, the fbclid value will be derived from the \u003cstrong\u003epage_location\u003c/strong\u003e event data key. If this is not available or you want to manually choose where to derive the \u003cstrong\u003efbclid\u003c/strong\u003e value from, you can choose the correct GTM variable from the drop-down."
  }
]


___SANDBOXED_JS_FOR_SERVER___

const computeEffectiveTldPlusOne = require('computeEffectiveTldPlusOne');
const decodeUriComponent = require('decodeUriComponent');
const generateRandom = require('generateRandom');
const getCookieValues = require('getCookieValues');
const getEventData = require('getEventData');
const getRequestHeader = require('getRequestHeader');
const getTimestampMillis = require('getTimestampMillis');
const parseUrl = require('parseUrl');

const fbc = getCookieValues('_fbc');
const domain = getEventData('page_location') || getRequestHeader('referer');
const subdomainIndex = domain ? computeEffectiveTldPlusOne(domain).split('.').length - 1 : 1;
const url = parseUrl(getEventData('page_location'));

let fbclid;

if (data.fbclidSource === 'automatic') {
  fbclid = url && url.searchParams.fbclid ? decodeUriComponent(url.searchParams.fbclid) : undefined;
} else {
  fbclid = data.fbclidSource;
}

return fbclid ? 'fb.' +
       subdomainIndex + '.' +
       getTimestampMillis() + '.' +
       fbclid : undefined;


___SERVER_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "read_request",
        "versionId": "1"
      },
      "param": [
        {
          "key": "headerWhitelist",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "headerName"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "referer"
                  }
                ]
              }
            ]
          }
        },
        {
          "key": "headersAllowed",
          "value": {
            "type": 8,
            "boolean": true
          }
        },
        {
          "key": "requestAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "headerAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "queryParameterAccess",
          "value": {
            "type": 1,
            "string": "any"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "read_event_data",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keyPatterns",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "page_location"
              }
            ]
          }
        },
        {
          "key": "eventDataAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  },
  {
    "instance": {
      "key": {
        "publicId": "get_cookies",
        "versionId": "1"
      },
      "param": [
        {
          "key": "cookieAccess",
          "value": {
            "type": 1,
            "string": "specific"
          }
        },
        {
          "key": "cookieNames",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 1,
                "string": "_fbc"
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___TESTS___

scenarios: []


___NOTES___

Created on 09/11/2021, 12:15:33


