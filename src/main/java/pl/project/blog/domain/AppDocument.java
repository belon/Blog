package pl.project.blog.domain;

import org.jcouchdb.db.Database;
import org.jcouchdb.document.BaseDocument;
import org.svenson.JSONProperty;

public abstract class AppDocument extends BaseDocument {

    @JSONProperty(value = "docType", readOnly = true)
    public String getDocumentType() {
        return this.getClass().getSimpleName();
    }

    /**
     * Meotda wywoływana przed zapisem do bazy danych.
     *
     * @param database
     */
    public void beforePersist(Database database) {
        return;
    }

    /**
     * Metoda wywoływana po zapisie do bazy danych.
     * 
     * @param database
     */
    public void afterPersist(Database database) {
        return;
    }

    /**
     * Metoda wywoływana przed uaktualnieniem dokumentu w bazie danych.
     * 
     * @param systemDatabase
     */
    public void beforeUpdate(Database systemDatabase) {
        return;
    }

    /**
     * Metoda wywoływana po uaktualnieniu dokumentu w bazie danych.
     * 
     * @param systemDatabase
     */
    public void afterUpdate(Database systemDatabase) {
        return;
    }
}
