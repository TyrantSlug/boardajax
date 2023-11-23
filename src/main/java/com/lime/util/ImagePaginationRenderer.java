package com.lime.util;

import egovframework.rte.ptl.mvc.tags.ui.pagination.AbstractPaginationRenderer;

public class ImagePaginationRenderer extends AbstractPaginationRenderer {
	
	public ImagePaginationRenderer() {
	    firstPageLabel    = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/egovframework/cmmn/btn_page_pre1.gif\" alt=\"첫 페이지\"></a>";
        previousPageLabel = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/egovframework/cmmn/btn_page_pre10.gif\" alt=\"이전 페이지\"></a>";
        currentPageLabel  = "<strong>{0}</strong>";
        otherPageLabel    = "<a href=\"#\" onclick=\"{0}({1}); return false;\">{2}</a>";
        nextPageLabel     = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/egovframework/cmmn/btn_page_next1.gif\" alt=\"다음 페이지\"></a>";
        lastPageLabel     = "<a href=\"#\" onclick=\"{0}({1}); return false;\"><img src=\"/images/egovframework/cmmn/btn_page_next10.gif\" alt=\"마지막 페이지\"></a>";
    }
}
