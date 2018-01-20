###EFFICIENT WAY
##170/77276
##
#
review1 <- lapply(paste0("https://www.amazon.com/Certified-Refurbished-Amazon-Echo-Generation/product-reviews/B00Y3QOH5G/ref=cm_cr_getr_d_paging_btm_1?filterByKeyword=privacy&search-alias=community-reviews&pageNumber=", 1:17, "#reviews-filter-bar"),
                  function(url){
                    url %>% read_html() %>% 
                      html_nodes(".review-text") %>% 
                      html_text()
                  })


review=unlist(review1,recursive = TRUE, use.names = TRUE)

##date
date<-  lapply(paste0("https://www.amazon.com/Certified-Refurbished-Amazon-Echo-Generation/product-reviews/B00Y3QOH5G/ref=cm_cr_getr_d_paging_btm_1?filterByKeyword=privacy&search-alias=community-reviews&pageNumber=", 1:17, "#reviews-filter-bar"),
               function(url){
                 url %>% read_html() %>% 
                   html_nodes(".a-col-left .review-date") %>%
                   html_text()
                 
               })  

date=unlist(date,recursive = TRUE, use.names = TRUE)

##star
star1<-   lapply(paste0("https://www.amazon.com/Certified-Refurbished-Amazon-Echo-Generation/product-reviews/B00Y3QOH5G/ref=cm_cr_getr_d_paging_btm_1?filterByKeyword=privacy&search-alias=community-reviews&pageNumber=", 1:17, "#reviews-filter-bar"),
                 function(url){
                   url %>% read_html() %>% 
                     html_nodes(".a-icon-alt") %>%
                     html_text()
                 })  
#TBC 
todrop <- which(star1[]=="|")
dat <- dat[-todrop,]
star1=lapply(star1, `[`, -todrop)

#TBC################# ?????how to slice every c(4:13) elements from all sublists in a nested list??

star=lapply(star, `[`, c(4:13))
star=unlist(star,recursive = TRUE, use.names = TRUE)

##count if condition suffice
sum(star[[17]][] != "|")
star=lapply(star, `[`,-star[] == "|")

nchar(star1[[1]][1])
nchar(star1[[1]][2])
###
star=c()
for (i in 1:17) {
  tmp=c()
  for (j in 1:length(star1[[i]]))
  {
    if (nchar(star1[[i]][j])>1){
      tmp=c(tmp,star1[[i]][j])
    }
  }
  star=c(star,tmp[4:13])
}

star

##title
title<-  lapply(paste0("https://www.amazon.com/Certified-Refurbished-Amazon-Echo-Generation/product-reviews/B00Y3QOH5G/ref=cm_cr_getr_d_paging_btm_1?filterByKeyword=privacy&search-alias=community-reviews&pageNumber=", 1:17, "#reviews-filter-bar"),
                function(url){
                  url %>% read_html() %>% 
                    html_nodes("#cm_cr-review_list .a-color-base") %>%
                    html_text()
                  
                })  
title=unlist(title,recursive = TRUE, use.names = TRUE)

###author
author<-  lapply(paste0("https://www.amazon.com/Certified-Refurbished-Amazon-Echo-Generation/product-reviews/B00Y3QOH5G/ref=cm_cr_getr_d_paging_btm_1?filterByKeyword=privacy&search-alias=community-reviews&pageNumber=", 1:17, "#reviews-filter-bar"),
                 function(url){
                   url %>% read_html() %>% 
                     html_nodes(".author") %>%
                     html_text()
                   
                 })  
author=unlist(author,recursive = TRUE, use.names = TRUE)


##dataframe
review_echo1=data.frame("ID"=1:170)
review_echo1$review=review
review_echo1$date=date

review_echo1$author=author
review_echo1$title=title
review_echo1$star=star