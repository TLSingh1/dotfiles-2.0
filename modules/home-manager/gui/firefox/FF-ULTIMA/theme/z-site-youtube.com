@-moz-document regexp("^https?://(www\\.)?youtubej\\..*") {
  * {
    background-color: transparent !important;
  }
}
