function(doc) {
    if (doc.docType == "PostTag") {
        emit(doc.post_id, doc);
    }
}