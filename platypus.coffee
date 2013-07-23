# #Platypus Gallery
# This is a jquery based slider gallery that feature
# two fullscreen options.
# ##Dependencies
# - jquery.js
# - underscore.js
# 
# passing onInit It is possible to provide a callback to invoke after the slider have been started
( 
	($)->
		$.fn.platypus= (cutomOptions = {})->
			# ##declare common variables
			options = {}
			
			# basic options
			options.fullscreen = if cutomOptions.fullscreen? then cutomOptions.fullscreen  else true
			options.arrows = if cutomOptions.arrows? then cutomOptions.arrows  else true
			options.initialSlide = if cutomOptions.initialSlide? then cutomOptions.initialSlide else 0
			options.onInit = if cutomOptions.onInit? then cutomOptions.onInit else null

			# common labels
			options.fullscreen_label = cutomOptions.fullscreen_label or 'fullscreen'
			options.zoom_label = cutomOptions.zoom_label or 'zoom'
			options.previous_label = cutomOptions.previous_label or 'previous'
			options.next_label = cutomOptions.next_label or 'next'
			
			# style
			bgColor = 'lightgrey'
			bulletsSize = 10
			bulletsColor = '#fff'
			bulletsHoverColor = '#666'
			bulletsActiveColor = '#222'
			options.animationSpeed = 800

			# animations
			fadeIn = """
				0%{
					transform: rotateY(0) scale(0)  translateY(-600px);
					-ms-transform: rotateY(0) scale(0)  translateY(-600px);
					-webkit-transform: rotateY(0) scale(0)  translateY(-600px);
				}
				20%{
					opacity: 0.5;
					box-shadow: rgba(0, 0, 0, 0.6) 0px 15px 30px;
					-moz-box-shadow: rgba(0, 0, 0, 0.6) 0px 15px 30px;
					-webkit-box-shadow: rgba(0, 0, 0, 0.6) 0px 15px 30px;
				}
				80%{
					box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 2px;
					-moz-box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 2px;
					-webkit-box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 2px;
				}
				100%{ 
					transform: rotateY(0) scaleY(1) translateY(0);
					-ms-transform: rotateY(0) scaleY(1) translateY(0);
					-webkit-transform: rotateY(0) scaleY(1) translateY(0);
					opacity: 1;
					box-shadow: rgba(0, 0, 0, 0.4) 0px 0 0;
					-moz-box-shadow: rgba(0, 0, 0, 0.4) 0px 0 0;
					-webkit-box-shadow: rgba(0, 0, 0, 0.4) 0px 0 0;
				}
			"""
			fadeOut = """
				0%{ 
					transform: rotateY(0) scaleY(1) translateY(0);
					-ms-transform: rotateY(0) scaleY(1) translateY(0);
					-webkit-transform: rotateY(0) scaleY(1) translateY(0);
					opacity: 1;
					box-shadow: rgba(0, 0, 0, 0.4) 0px 0 0;
					-moz-box-shadow: rgba(0, 0, 0, 0.4) 0px 0 0;
					-webkit-box-shadow: rgba(0, 0, 0, 0.4) 0px 0 0;
				}
				20%{
					box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 2px;
					-moz-box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 2px;
					-webkit-box-shadow: rgba(0, 0, 0, 0.4) 0px 2px 2px;
				}
				80%{
					opacity: 0.5;
					box-shadow: rgba(0, 0, 0, 0.6) 0px 15px 30px;
					-moz-box-shadow: rgba(0, 0, 0, 0.6) 0px 15px 30px;
					-webkit-box-shadow: rgba(0, 0, 0, 0.6) 0px 15px 30px;
				}
				100%{
					transform: rotateY(0) scale(0)  translateY(-600px);
					-ms-transform: rotateY(0) scale(0)  translateY(-600px);
					-webkit-transform: rotateY(0) scale(0)  translateY(-600px);
				}
			"""

			options.baseStyle = cutomOptions.baseStyle or """
			.platypus_Holder {
				margin: 20px auto;
			}
			
			#platypus_fullscreen {
				position: fixed;
				top: 0;
				z-index: 9999;
				left: 0;
				right: 0;
				bottom: 0;
				background: #fff;
				background: rgba(255,255,255,.8);
				padding-top: 5%;
			}

			.platypus{
				width: 100%;
			}
			.platypus .slide {
				margin: 0 auto; 
				display: block;
				overflow: hidden;
				text-align: center;

				perspective: 100;
				-ms-perspective: 100;
				-webkit-perspective: 100;
				height: 0;
				opacity: 0;
				position: relative;
				
			}
			.platypus .slide.active {
				display: table;
				opacity: 1;
				height: auto;
				overflow: visible;

				animation: platypus_fadeIn 800ms cubic-bezier(0.215, 0.61, 0.355, 1);
				-ms-animation: platypus_fadeIn 800ms cubic-bezier(0.215, 0.61, 0.355, 1);
				-webkit-animation: platypus_fadeIn 800ms cubic-bezier(0.215, 0.61, 0.355, 1);

				transform: rotateY(0) scaleY(1) translateY(0);
				-ms-transform: rotateY(0) scaleY(1) translateY(0);
				-webkit-transform: rotateY(0) scaleY(1) translateY(0);
			}

			.platypus .slide.hide {
				animation: platypus_fadeOut 600ms cubic-bezier(0.215, 0.61, 0.355, 1);
				-ms-animation: platypus_fadeOut 600ms cubic-bezier(0.215, 0.61, 0.355, 1);
				-webkit-animation: platypus_fadeOut 600ms cubic-bezier(0.215, 0.61, 0.355, 1);
				
				transform: rotateY(0) scale(0)  translateY(-600px);
				-ms-transform: rotateY(0) scale(0)  translateY(-600px);
				-webkit-transform: rotateY(0) scale(0)  translateY(-600px);

				height: 0;
				opacity: 0;
			}

			@-webkit-keyframes platypus_fadeIn {#{fadeIn}}
			@-moz-keyframes platypus_fadeIn {#{fadeIn}}
			@-ms-keyframes platypus_fadeIn {#{fadeIn}}
			@-o-keyframes platypus_fadeIn {#{fadeIn}}
			
			@-webkit-keyframes platypus_fadeOut {#{fadeOut}}
			@-moz-keyframes platypus_fadeOut {#{fadeOut}}
			@-ms-keyframes platypus_fadeOut {#{fadeOut}}
			@-o-keyframes platypus_fadeOut {#{fadeIn}}

			.platypus .slide.fadeOut {
			}
			.platypus .slide figure {
				width: 100%;
			}
			.platypus .slide figure img {
				width: 100%;
				max-width: 100%;
				display: block;
			}
			.platypus .slide figure figcaption {
				background: #{bgColor};
				padding: 20px 0 40px 0;
			}
			.platypus .slide .platypus_fullscreenBtn{
				position: relative;
				top: 22px;
				float: right;
			}

			.platypus_nav{
				padding: 20px 0;
				# background: #{bgColor};
				margin: 0 auto;
				top: -45px;
				position: relative;
			}
			.platypus_arrowsHolder{
				margin: 0 auto;
				margin-top: 0;
				position: absolute;
				top: 50%;
				width: 100%
			}
			.platypus_arrow.platypus_prevBtn {
				float: left;
			}
			.platypus_arrow.platypus_nextBtn {
				float: right;
			}
			.platypus_bullets{
				display: table;
				margin: 0 auto;
			}
			.platypus_bullets .platypus_bullet{
				cursor: pointer;
				display: block;
				width: #{bulletsSize}px;
				height: #{bulletsSize}px;
				margin-right: #{bulletsSize/2}px;
				background: #{bulletsColor};
				float: left;
				-webkit-border-radius: 50%;
				-moz-border-radius: 50%;
				border-radius: 50%;
			}
			.platypus_bullets .platypus_bullet:last-child{
				margin-right: 0;
			}
			.platypus_bullets .platypus_bullet:hover{
				background: #{bulletsHoverColor};
			}
			.platypus_bullets .platypus_bullet.active{
				background: #{bulletsActiveColor};
			}
			"""

			# ###Create Gallery
			# This is used to create the gallery.
			# The this value should be binded to the jquery element for the single entry
			createGallery = (options)->
				$el = $(this)
				$el.wrap("<div class='platypus_Holder'>")
				$wrapper = $el.parent()

				# cache teh original html to reuse for fullscreen mode
				originalHtml = $wrapper.html()

				# Assign unique id to teh gallery
				galleryId = _.uniqueId('platypus_')
				$el.attr 'id', galleryId
				
				# assign uniq id to the slides
				$el.find('li').each(
					(ind)->
						$(this).addClass('slide').attr 'id', "#{galleryId}_#{ind}"
				)
				
				# ####Add the interface
				addInterface = ()->

					# add the full-screen menu
					if options.fullscreen
						$el.find('li').prepend templ_fullscreenBtn(options)

					# add bullets
						ids = _.map(
							$el.find('.slide').toArray()
							(el)->
								return $(el).attr('id')
						)
						if ids.length > 1
							$wrapper.append templ_bullets({ids: ids})

							# add arrows
							if options.arrows
								_.each(
									$el.find('.slide').toArray()
									(el)->
										$(el).append templ_arrows(options)
								)

				# ####navigate to a slide
				navigateTo = (id)->
					galleryId = $(this).attr 'id'
					# deactivate old slides
					$(this).find('.slide.active').addClass 'hide'
					$(this).find('.slide').removeClass 'active'
					# deactivate old bulet
					$(this).parent().find('.platypus_bullet').removeClass 'active'

					# activate slide
					$("##{galleryId}_#{id}").removeClass('hide').addClass 'active'
					# activate bullet
					$("##{galleryId.replace('platypus_', 'platypus_bullet_')}_#{id}").addClass 'active'

					# resize the slide
					# resize.call $("##{galleryId}_#{id}")

				# chose transition strategy CSS3 or jquery

				# ####fullscreen
				# toggle fullscreen mode
				fullscreen = ->
					currentId = Number($(this).find('.slide.active').attr('id').split('_').pop())
					$('body').append templ_fullscreenHolder({gallery: originalHtml})
					fOptions = options
					fOptions.initialSlide = currentId
					$('#platypus_fullscreen > .platypus').platypus fOptions

				# ####bind actions
				bindActions = ->
					that = this

					# bind bullets navigation
					$wrapper.on(
						'click'
						'.platypus_bullet'
						->
							# navigate to the proper slide
							navigateTo.call that, $(this).attr('id').split('_').pop()
							# resize.call that
					)

					# bind arrows navigation
					$wrapper.on(
						'click'
						'.platypus_arrow'
						->
							# navigate to the proper slide
							direction = if $(this).hasClass('platypus_prevBtn') then -1 else 1
							currentId = Number($(that).find('.slide.active').attr('id').split('_').pop())
							# enable slide loop
							if currentId is 0
								currentId = $(that).find('.slide').length
							target = (currentId + direction) % $(that).find('.slide').length
							navigateTo.call that, target
							# resize.call that
					)

					$wrapper.on(
						'click'
						'.platypus_fullscreenBtn'
						->
							# append fullscreen
							unless $(that).parent().parent().attr('id') is 'platypus_fullscreen'
								fullscreen.call that
							else
							# remove fullscreen
								$(that).parent().parent().remove()
					)

				# ####zoom
				# toggle zoom mode loading the full size image

				addInterface.call this
				bindActions.call this
				navigateTo.call this, options.initialSlide
				if options.onInit?
					options.onInit()
				
				# resize.call this, 0
				return this
			
			appendStyle options.baseStyle
			return this.each(
				->
					createGallery.call this, options
			)


		# ##Append Style
		# this will pre-append the style to the header to ease override by the site css
		appendStyle = (style)->
			unless $('#platypus_Style').length
				$("<style type='text/css' id='platypus_Style'>#{style}</style>").prependTo($('head'))
		
		# ##Check css3 transitions support
		supportTransitions = ->

		# ## Templates
		templ_fullscreenHolder = _.template """
			<div id='platypus_fullscreen'>
				<%= gallery %>
			</div>
		"""

		templ_fullscreenBtn = _.template """
			<button class='platypus_fullscreenBtn' type="button"><%- fullscreen_label %></button>
		"""

		templ_bullets = _.template """
			<div class='platypus_nav'>
				<ul class='platypus_bullets'>
					<% _.each(ids, function(id){ %>
						<li class='platypus_bullet' id='<%= id.replace('platypus', 'platypus_bullet') %>' data-target='<%= id %>'> </li>
					<% }) %>
				</ul>
			</div>
		"""

		templ_arrows = _.template """
			<div class='platypus_arrowsHolder'>
				<button class='platypus_arrow platypus_prevBtn' type="button"><%- previous_label %></button>
				<button class='platypus_arrow platypus_nextBtn' type="button"><%- next_label %></button>
			</div>
		"""

)( jQuery )
