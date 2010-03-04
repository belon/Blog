function(doc) {
    if (doc.docType == "Post") {
        emit(doc.title, null);
    }
}

