var defaultPatterns = [
    '^https://github.com',
    '^https://gist.github.com'
];

function loadPatterns() {
    var patternsBox = document.getElementById('patterns');
    chrome.storage.sync.get({
        'patterns': []
    }, function(items) {
        var patterns = items['patterns'];
        if (patterns.length == 0) {
            patternsBox.value = defaultPatterns.join('\r\n');
        } else {
            patternsBox.value = patterns.join('\r\n');
        }
    });
}

function savePatterns() {
    var patternsBox = document.getElementById('patterns');
    var patterns = patternsBox.value.split('\n').map(function(p) {
        return p.trim();
    }).filter(function(p) {
        return p != '';
    });
    chrome.storage.sync.set({
        'patterns': patterns
    });
}

function resetPatterns() {
    chrome.storage.sync.clear(loadPatterns);
}

document.addEventListener('DOMContentLoaded', function() {
    loadPatterns();
    var saveButton = document.getElementById('save');
    saveButton.addEventListener('click', savePatterns);

    var reloadButton = document.getElementById('reload');
    reloadButton.addEventListener('click', loadPatterns);

    var resetButton = document.getElementById('reset');
    resetButton.addEventListener('click', resetPatterns);
});

