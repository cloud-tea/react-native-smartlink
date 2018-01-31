'use strict';

const argscheck = require('@cloudtea/react-native-cordova').argscheck,
    exec = require('@cloudtea/react-native-cordova').exec,
    isandroid = require('@cloudtea/react-native-cordova').isandroid;

exports.getSSID = function(arg0, success, error) {
    exec(success, error, "RNSmartLink", "getSSID", [arg0]);
};

exports.connect = function(arg0, success, error) {
    exec(success, error, "RNSmartLink", "connect", [arg0]);
};

