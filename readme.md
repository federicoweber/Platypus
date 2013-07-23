# Platypus
A simple carousel plugin for jquery.

## Use it
It will convert a list of elements into a carousel

	<ul class="platypus">
		<li>
			<figure><img src="http://dummyimage.com/2000x700/4d494d/686a82.gif&amp;text=focus" alt="Macaque in the trees">
				<figcaption>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</figcaption>
			</figure>
		</li>
		<li>
			<figure><img src="http://dummyimage.com/936x470/4d494d/686a82.gif&amp;text=focus" alt="Macaque in the trees">
				<figcaption>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</figcaption>
			</figure>
		</li>
		<li>
			<figure><img src="http://dummyimage.com/436x670/4d494d/686a82.gif&amp;text=focus" alt="Macaque in the trees">
				<figcaption>Lorem ipsum dolor sit amet, consectetur adipiscing elit.</figcaption>
			</figure>
		</li>
	</ul>

To use it run
	
	$('.platypus').platypus(options)

## Options
Available custom options *to be provided on initialization*

- options.fullscreen = **Boolean** enable the fullscreen button; default is **true**
- options.arrows = **Boolean** enable arrow navigation; default is **true**
- options.initialSlide = **Number** the first active slide; default is 0
- options.onInit = **Function** a callback function to call after the slider have been inited
- options.fullscreen_label = **String** the fullscreen button label; default is 'fullscreen'
- options.zoom_label = **String** the zoom button label; default is 'zoom'
- options.previous_label = **String** the previous button label; default is 'previous'
- options.next_label = **String** the next button label; default is 'next'