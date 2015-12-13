var patterns;

function addListeners() {
    chrome.tabs.onUpdated.addListener(rearrangeTabs);
    chrome.tabs.onAttached.addListener(rearrangeTabs);
    chrome.tabs.onCreated.addListener(rearrangeTabs);
    chrome.storage.onChanged.addListener(function(changes) {
        patterns = changes['patterns']['newValue'];
        rearrangeTabs();
    });
}

function loadPatterns() {
    chrome.storage.sync.get({
        'patterns': []
    }, function(items) {
        patterns = items['patterns'];
    });
}

function rearrangeTabs() {
    chrome.tabs.query({}, function(tabs) {
        // We can't move anything to the left of the pinned
        // tabs, so figure out how many there are, that is
        // our left-most target index.
        var targetIndex = tabs.reduce(function(count, tab) {
            if (tab.pinned) {
                return count + 1;
            } else {
                return count;
            }
        }, 0);

        for (var i = 0; i < patterns.length; i++) {
            var pattern = patterns[i];
            for (var j = 0; j < tabs.length; j++) {
                var tab = tabs[j];
                if (tab.url.match(pattern)) {
                    if (tab.index != targetIndex) {
                        chrome.tabs.move(tab.id, {
                            index: targetIndex++
                        });
                    } else {
                        targetIndex += 1;
                    }
                }
            }
        }
    });
}

loadPatterns();
addListeners();

