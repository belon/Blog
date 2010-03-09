function(doc) {
    if (doc.docType == "Post") {
        emit(doc.createDate, null);
    }
}

