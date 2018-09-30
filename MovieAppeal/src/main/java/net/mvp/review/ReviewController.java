package net.mvp.review;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ReviewController {
	
	private static final Logger logger = LoggerFactory.getLogger(ReviewController.class);
	
	
	@RequestMapping(value = "/review.do")
	public ModelAndView home() {
		ModelAndView mav = new ModelAndView();
		String url = "review";
		mav.addObject("page",url);
		mav.setViewName("mainLayout");
		return mav;
	}
}
