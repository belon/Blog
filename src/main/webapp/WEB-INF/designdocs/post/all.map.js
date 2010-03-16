function(doc) {
    if (doc.docType == "Post") {
        emit([doc._id, 0, doc.createDate], doc);
    } else if (doc.docType == "Comment") {
        emit([doc.post_id, 1, doc.created], doc);
    } else if (doc.docType == "PostTag") {
        emit([doc.post_id, 2, doc.tag_id], doc);
    }
}

