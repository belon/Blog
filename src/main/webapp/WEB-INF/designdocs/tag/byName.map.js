function(doc) {
    if (doc.docType == "Tag") {
        emit(doc.name, null);
    }
}