function(doc) {
    if (doc.docType == "Comment") {
        emit(doc.post_id, null);
    }
}

