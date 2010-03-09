function(doc) {
    if (doc.docType == "User") {
        emit(doc.name, null);
    }
}