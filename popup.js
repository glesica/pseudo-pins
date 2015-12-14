var defaultPatterns = [
    '^https://github.com',
    '^https://gist.github.com'
];

var currentPatternsContent;

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
        currentPatternsContent = patternsBox.value;
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
    currentPatternsContent = patternsBox.value;
    patternsBox.style.background = '';
}

function resetStorage() {
    chrome.storage.sync.clear(loadPatterns);
    chrome.storage.local.clear(loadDisabledState);
}

function setIcon(disabled) {
    var mod = '';
    if (disabled) {
        mod = '-light';
    }
    chrome.browserAction.setIcon({
        path: {
            19: 'icons/icon19' + mod + '.png',
            38: 'icons/icon38' + mod + '.png'
        }
    });
}

function loadDisabledState() {
    var disabledCheck = document.getElementById('disabled');
    chrome.storage.local.get({
        'disabled': false
    }, function(items) {
        var disabled = items['disabled'];
        disabledCheck.checked = disabled;
        setIcon(disabled);
    });
}

function saveDisabledState() {
    var disabledCheck = document.getElementById('disabled');
    chrome.storage.local.set({
        'disabled': disabledCheck.checked
    }, function() {
        setIcon(disabledCheck.checked);
    });
}

document.addEventListener('DOMContentLoaded', function() {
    loadPatterns();
    loadDisabledState();

    var saveButton = document.getElementById('save');
    saveButton.addEventListener('click', savePatterns);

    var reloadButton = document.getElementById('reload');
    reloadButton.addEventListener('click', loadPatterns);

    var resetButton = document.getElementById('reset');
    resetButton.addEventListener('click', resetStorage);

    var helpToggle = document.getElementById('help-toggle');
    helpToggle.addEventListener('click', function() {
        var helpSection = document.getElementById('help');
        if (helpSection.style.display == '') {
            helpSection.style.display = 'block';
        } else {
            helpSection.style.display = '';
        }
    });

    var disabledCheck = document.getElementById('disabled');
    disabledCheck.addEventListener('change', saveDisabledState);

    var patternsBox = document.getElementById('patterns');
    patternsBox.addEventListener('input', function(e) {
        if (e.target.value != currentPatternsContent) {
            e.target.style.background = '#ffeeee';
        } else {
            e.target.style.background = '';
        }
    });
});

