function(doc) {
    if (doc.docType == "Comment") {
        emit(doc.author, null);
    }
}

