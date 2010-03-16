function(doc) {
    if (doc.docType == "Post") {
        emit(doc._id, null);
    } else if (doc.docType == "Comment") {
        emit(doc.post_id, null);
    } else if (doc.docType == "PostTag") {
        emit(doc.post_id, null);
    }
}