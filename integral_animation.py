from manim import *
import numpy as np

class DifficultIntegral(Scene):
    def construct(self):
        # Set up layout areas with more separation
        title_area = Rectangle(height=1, width=14, color=WHITE, fill_opacity=0)
        title_area.to_edge(UP, buff=0.2)
        
        left_area = Rectangle(height=5, width=5, color=WHITE, fill_opacity=0)
        left_area.next_to(title_area, DOWN).shift(LEFT * 3 + DOWN * 0.5)
        
        right_area = Rectangle(height=5, width=5, color=WHITE, fill_opacity=0)
        right_area.next_to(title_area, DOWN).shift(RIGHT * 3 + DOWN * 0.5)
        
        bottom_area = Rectangle(height=1, width=14, color=WHITE, fill_opacity=0)
        bottom_area.to_edge(DOWN, buff=0.2)

        # Title - using MathTex instead of Text for proper LaTeX rendering
        title = MathTex(
            r"\text{Integral: } \int_{0}^{\infty} \frac{x^3}{e^x - 1} \, dx = \frac{\pi^4}{15}",
            font_size=36
        )
        title.move_to(title_area)
        self.play(Write(title))
        self.wait(2)

        # Axes and labels - make the graph smaller and position it in the left side
        axes = Axes(
            x_range=[0, 8, 1],
            y_range=[0, 1, 0.2],
            x_length=4.5,
            y_length=3,
            tips=True,
            axis_config={"include_numbers": True, "font_size": 20}
        )
        axes.move_to(left_area.get_center())
        
        x_label = axes.get_x_axis_label("x")
        
        # Create a background for function label to make it stand out
        func_label_box = Rectangle(height=0.6, width=2.2, color=WHITE, fill_color=BLACK, fill_opacity=0.7)
        func_label_box.to_edge(UP, buff=1.5).shift(LEFT * 3)
        
        y_label = MathTex(r"f(x) = \frac{x^3}{e^x - 1}", font_size=22)
        y_label.move_to(func_label_box.get_center())
        
        axis_labels = VGroup(x_label, y_label)
        
        self.play(Create(axes), FadeIn(func_label_box), Write(axis_labels))
        self.wait(1)

        # Define the function for plotting
        def func(x):
            # Avoid dividing by zero at x=0; the integrand ~ x^2 near 0, but we'll just skip 0 in the plot
            return (x**3)/(np.e**x - 1) if x > 1e-9 else 0

        # Plot the function from x=0.001 to x=8 as an approximation
        graph = axes.plot(func, x_range=[0.001, 8], use_smoothing=False)
        self.play(Create(graph))
        self.wait(1.5)

        # Shade the area under the curve
        area = axes.get_area(graph, x_range=[0.001, 8], opacity=0.3)
        self.play(FadeIn(area))
        self.wait(1.5)

        # Add a divider line between graph and steps
        divider = Line(
            start=[0, 2.5, 0], 
            end=[0, -2.5, 0],
            stroke_width=1,
            color=GREY
        )
        self.play(Create(divider))
        
        # Present the step-by-step idea of the derivation
        # Position them on the right side with clear spacing
        step_1 = MathTex(
            r"1) \text{Expand } \frac{1}{e^x - 1} = \sum_{n=1}^{\infty} e^{-nx}.",
            font_size=24
        )
        step_2 = MathTex(
            r"2) \text{Rewrite } \int_0^\infty x^3 \sum_{n=1}^{\infty} e^{-nx} \, dx.",
            font_size=24
        )
        
        # Create background box for steps 3 and 4
        step3_box = Rectangle(height=2.2, width=5, color=BLACK, fill_color=BLACK, fill_opacity=0.7)
        step3_box.next_to(right_area.get_center(), DOWN, buff=0)
        
        step_3 = MathTex(
            r"3) \text{Interchange sum and integral,}", 
            font_size=24
        )
        step_3_cont = MathTex(
            r"\quad\text{apply }\Gamma \text{ function.}",
            font_size=24
        )
        step_4 = MathTex(
            r"4) \text{Result: } \Gamma(4)\zeta(4) = 3! \cdot \frac{\pi^4}{90} = \frac{\pi^4}{15}.",
            font_size=24
        )

        # Create step group and position steps 1 and 2
        steps_top = VGroup(step_1, step_2).arrange(DOWN, buff=0.5, aligned_edge=LEFT)
        steps_top.move_to(right_area.get_center() + UP * 1)
        
        # Create step group for 3 and 4 with the background
        step_3.move_to(step3_box.get_center() + UP * 0.6)
        step_3_cont.move_to(step3_box.get_center() + UP * 0.1)
        step_4.move_to(step3_box.get_center() + DOWN * 0.5)
        steps_bottom = VGroup(step_3, step_3_cont, step_4)
        
        self.play(FadeIn(step_1))
        self.wait(1)
        self.play(FadeIn(step_2))
        self.wait(1)
        
        # Add background box before steps 3 and 4
        self.play(FadeIn(step3_box))
        self.play(FadeIn(step_3))
        self.wait(0.5)
        self.play(FadeIn(step_3_cont))
        self.wait(1)
        self.play(FadeIn(step_4))
        self.wait(2)

        # Final statement - using MathTex instead of Text for proper LaTeX rendering
        final_box = Rectangle(height=1, width=8, color=BLACK, fill_color=BLACK, fill_opacity=0.7)
        final_box.move_to(bottom_area)
        
        final_text = MathTex(
            r"\text{Hence, } \int_{0}^{\infty} \frac{x^3}{e^x - 1} \, dx = \frac{\pi^4}{15}",
            font_size=32
        )
        final_text.move_to(final_box)
        
        self.play(FadeIn(final_box))
        self.play(Write(final_text))
        self.wait(3)

        # Clean up
        self.play(
            FadeOut(final_text),
            FadeOut(final_box),
            FadeOut(step3_box),
            FadeOut(steps_top),
            FadeOut(steps_bottom),
            FadeOut(divider),
            FadeOut(area),
            FadeOut(graph),
            FadeOut(axis_labels),
            FadeOut(func_label_box),
        )
        self.wait()
        self.play(Uncreate(axes))
        self.play(Unwrite(title))
        self.wait() 