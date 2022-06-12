# frozen_string_literal: true

Ransack.configure do |c|
  c.custom_arrows = {
    up_arrow: '<svg width="24" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                 <path d="M6 13L12 19L18 13H6Z" fill="#1A1A1A" fill-opacity="0.2"/>
                 <path d="M6 11L12 5L18 11H6Z" fill="#2F8F9D"/>
               </svg>',
    down_arrow: '<svg width="24" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                   <path d="M6 13L12 19L18 13H6Z" fill="#2F8F9D"/>
                   <path d="M6 11L12 5L18 11H6Z" fill="#1A1A1A" fill-opacity="0.2"/>
                 </svg>',
    default_arrow: '<svg width="24" height="20" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path d="M6 13L12 19L18 13H6Z" fill="#2F8F9D"/>
                      <path d="M6 11L12 5L18 11H6Z" fill="#2F8F9D"/>
                    </svg>'
  }
end
