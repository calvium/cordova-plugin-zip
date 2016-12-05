var exec = cordova.require('cordova/exec');

function newProgressEvent(result) {
    var event = {
            loaded: result.loaded,
            total: result.total
    };
    return event;
}

exports.unzip = function(fileName, outputDirectory, callback, progressCallback) {
    var win = function(result) {
        if (result && typeof result.loaded != "undefined") {
            if (progressCallback) {
                return progressCallback(newProgressEvent(result));
            }
        } else if (callback) {
            callback(0);
        }
    };
    var fail = function(result) {
        if (callback) {
            callback(-1);
        }
    };
    exec(win, fail, 'Zip', 'unzip', [fileName, outputDirectory]);
};
exports.getDocRoot_OnlyiOS = function(callback) {
    var win = callback && function() {
            callback(0, arguments[0]);
        };
    var fail = callback && function() {
            callback(-1, arguments[0]);
        };
    exec(win, fail, 'Zip', 'docRoot', []);
};
