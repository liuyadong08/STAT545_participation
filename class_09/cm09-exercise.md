cm009 Exercises: tidy data
================

``` r
suppressPackageStartupMessages(library(tidyverse))
```

## Reading and Writing Data: Exercises

Make a tibble of letters, their order in the alphabet, and then a
pasting of the two columns together.

``` r
tibble(let = letters, 
       num = 1:length(letters), 
       comb = paste(let, num))
```

    ## # A tibble: 26 x 3
    ##    let     num comb 
    ##    <chr> <int> <chr>
    ##  1 a         1 a 1  
    ##  2 b         2 b 2  
    ##  3 c         3 c 3  
    ##  4 d         4 d 4  
    ##  5 e         5 e 5  
    ##  6 f         6 f 6  
    ##  7 g         7 g 7  
    ##  8 h         8 h 8  
    ##  9 i         9 i 9  
    ## 10 j        10 j 10 
    ## # ... with 16 more rows

Make a tibble of three names and commute times.

``` r
tribble(
  ~name, ~time,
  "Frank", 30,
  "Lisa", 15,
  "Fred", 40
)
```

    ## # A tibble: 3 x 2
    ##   name   time
    ##   <chr> <dbl>
    ## 1 Frank  30.0
    ## 2 Lisa   15.0
    ## 3 Fred   40.0

Write the `iris` data frame as a `csv`.

``` r
write_csv(iris, "iris.csv")
```

Write the `iris` data frame to a file delimited by a dollar sign.

``` r
write_delim(iris, "iris.txt", delim = "$")
```

Read the dollar-delimited `iris` data to a tibble.

``` r
read_delim("iris.txt", delim = "$")
```

    ## Parsed with column specification:
    ## cols(
    ##   Sepal.Length = col_double(),
    ##   Sepal.Width = col_double(),
    ##   Petal.Length = col_double(),
    ##   Petal.Width = col_double(),
    ##   Species = col_character()
    ## )

    ## # A tibble: 150 x 5
    ##    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
    ##           <dbl>       <dbl>        <dbl>       <dbl> <chr>  
    ##  1         5.10        3.50         1.40       0.200 setosa 
    ##  2         4.90        3.00         1.40       0.200 setosa 
    ##  3         4.70        3.20         1.30       0.200 setosa 
    ##  4         4.60        3.10         1.50       0.200 setosa 
    ##  5         5.00        3.60         1.40       0.200 setosa 
    ##  6         5.40        3.90         1.70       0.400 setosa 
    ##  7         4.60        3.40         1.40       0.300 setosa 
    ##  8         5.00        3.40         1.50       0.200 setosa 
    ##  9         4.40        2.90         1.40       0.200 setosa 
    ## 10         4.90        3.10         1.50       0.100 setosa 
    ## # ... with 140 more rows

Read these three LOTR csv’s, saving them to `lotr1`, `lotr2`, and
`lotr3`:

  - <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv>
  - <https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Two_Towers.csv>
  - <https://https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv>

<!-- end list -->

``` r
lotr1 <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

``` r
lotr2 <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Fellowship_Of_The_Ring.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

``` r
lotr3 <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/The_Return_Of_The_King.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Female = col_integer(),
    ##   Male = col_integer()
    ## )

## `gather()`

(Exercises largely based off of Jenny Bryan’s [gather
tutorial](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md))

This function is useful for making untidy data tidy (so that computers
can more easily crunch the numbers).

1.  Combine the three LOTR untidy tables (`lotr1`, `lotr2`, `lotr3`) to
    a single untidy table by stacking them.

<!-- end list -->

``` r
(lotr_untidy <- bind_rows(lotr1, lotr2, lotr3))
```

    ## # A tibble: 9 x 4
    ##   Film                       Race   Female  Male
    ##   <chr>                      <chr>   <int> <int>
    ## 1 The Fellowship Of The Ring Elf      1229   971
    ## 2 The Fellowship Of The Ring Hobbit     14  3644
    ## 3 The Fellowship Of The Ring Man         0  1995
    ## 4 The Fellowship Of The Ring Elf      1229   971
    ## 5 The Fellowship Of The Ring Hobbit     14  3644
    ## 6 The Fellowship Of The Ring Man         0  1995
    ## 7 The Return Of The King     Elf       183   510
    ## 8 The Return Of The King     Hobbit      2  2673
    ## 9 The Return Of The King     Man       268  2459

2.  Convert to tidy. Also try this by specifying columns as a range, and
    with the `contains()` function.

<!-- end list -->

``` r
gather(lotr_untidy, key = "Gender", value = "Word", Female, Male)
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender  Word
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Fellowship Of The Ring Elf    Female  1229
    ##  5 The Fellowship Of The Ring Hobbit Female    14
    ##  6 The Fellowship Of The Ring Man    Female     0
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Fellowship Of The Ring Elf    Male     971
    ## 14 The Fellowship Of The Ring Hobbit Male    3644
    ## 15 The Fellowship Of The Ring Man    Male    1995
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

``` r
gather(lotr_untidy, key = "Gender", value = "Word", Female:Male)
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender  Word
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Fellowship Of The Ring Elf    Female  1229
    ##  5 The Fellowship Of The Ring Hobbit Female    14
    ##  6 The Fellowship Of The Ring Man    Female     0
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Fellowship Of The Ring Elf    Male     971
    ## 14 The Fellowship Of The Ring Hobbit Male    3644
    ## 15 The Fellowship Of The Ring Man    Male    1995
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

``` r
gather(lotr_untidy, key = "Gender", value = "Word", contains("ale"))
```

    ## # A tibble: 18 x 4
    ##    Film                       Race   Gender  Word
    ##    <chr>                      <chr>  <chr>  <int>
    ##  1 The Fellowship Of The Ring Elf    Female  1229
    ##  2 The Fellowship Of The Ring Hobbit Female    14
    ##  3 The Fellowship Of The Ring Man    Female     0
    ##  4 The Fellowship Of The Ring Elf    Female  1229
    ##  5 The Fellowship Of The Ring Hobbit Female    14
    ##  6 The Fellowship Of The Ring Man    Female     0
    ##  7 The Return Of The King     Elf    Female   183
    ##  8 The Return Of The King     Hobbit Female     2
    ##  9 The Return Of The King     Man    Female   268
    ## 10 The Fellowship Of The Ring Elf    Male     971
    ## 11 The Fellowship Of The Ring Hobbit Male    3644
    ## 12 The Fellowship Of The Ring Man    Male    1995
    ## 13 The Fellowship Of The Ring Elf    Male     971
    ## 14 The Fellowship Of The Ring Hobbit Male    3644
    ## 15 The Fellowship Of The Ring Man    Male    1995
    ## 16 The Return Of The King     Elf    Male     510
    ## 17 The Return Of The King     Hobbit Male    2673
    ## 18 The Return Of The King     Man    Male    2459

3.  Try again (bind and tidy the three untidy data frames), but without
    knowing how many tables there are originally.
      - The additional work here does not require any additional tools
        from the tidyverse, but instead uses a `do.call` from base R – a
        useful tool in data analysis when the number of “items” is
        variable/unknown, or quite large.

<!-- end list -->

``` r
lotr_list <- list(lotr1, lotr2, lotr3)
lotr_list
```

    ## [[1]]
    ## # A tibble: 3 x 4
    ##   Film                       Race   Female  Male
    ##   <chr>                      <chr>   <int> <int>
    ## 1 The Fellowship Of The Ring Elf      1229   971
    ## 2 The Fellowship Of The Ring Hobbit     14  3644
    ## 3 The Fellowship Of The Ring Man         0  1995
    ## 
    ## [[2]]
    ## # A tibble: 3 x 4
    ##   Film                       Race   Female  Male
    ##   <chr>                      <chr>   <int> <int>
    ## 1 The Fellowship Of The Ring Elf      1229   971
    ## 2 The Fellowship Of The Ring Hobbit     14  3644
    ## 3 The Fellowship Of The Ring Man         0  1995
    ## 
    ## [[3]]
    ## # A tibble: 3 x 4
    ##   Film                   Race   Female  Male
    ##   <chr>                  <chr>   <int> <int>
    ## 1 The Return Of The King Elf       183   510
    ## 2 The Return Of The King Hobbit      2  2673
    ## 3 The Return Of The King Man       268  2459

``` r
do.call(bind_rows, lotr_list)
```

    ## # A tibble: 9 x 4
    ##   Film                       Race   Female  Male
    ##   <chr>                      <chr>   <int> <int>
    ## 1 The Fellowship Of The Ring Elf      1229   971
    ## 2 The Fellowship Of The Ring Hobbit     14  3644
    ## 3 The Fellowship Of The Ring Man         0  1995
    ## 4 The Fellowship Of The Ring Elf      1229   971
    ## 5 The Fellowship Of The Ring Hobbit     14  3644
    ## 6 The Fellowship Of The Ring Man         0  1995
    ## 7 The Return Of The King     Elf       183   510
    ## 8 The Return Of The King     Hobbit      2  2673
    ## 9 The Return Of The King     Man       268  2459

## `spread()`

(Exercises largely based off of Jenny Bryan’s [spread
tutorial](https://github.com/jennybc/lotr-tidy/blob/master/03-spread.md))

This function is useful for making tidy data untidy (to be more pleasing
to the eye).

Read in the tidy LOTR data (despite having just made
it):

``` r
lotr_tidy <- read_csv("https://raw.githubusercontent.com/jennybc/lotr-tidy/master/data/lotr_tidy.csv")
```

    ## Parsed with column specification:
    ## cols(
    ##   Film = col_character(),
    ##   Race = col_character(),
    ##   Gender = col_character(),
    ##   Words = col_integer()
    ## )

Get word counts across “Race”. Then try “Gender”.

``` r
spread(lotr_tidy, key = "Race", value = "Words")
```

    ## # A tibble: 6 x 5
    ##   Film                       Gender   Elf Hobbit   Man
    ## * <chr>                      <chr>  <int>  <int> <int>
    ## 1 The Fellowship Of The Ring Female  1229     14     0
    ## 2 The Fellowship Of The Ring Male     971   3644  1995
    ## 3 The Return Of The King     Female   183      2   268
    ## 4 The Return Of The King     Male     510   2673  2459
    ## 5 The Two Towers             Female   331      0   401
    ## 6 The Two Towers             Male     513   2463  3589

Now try combining race and gender. Use `unite()` from `tidyr` instead of
`paste()`.

``` r
lotr_tidy %>% 
  unite(Race_Gender, Race, Gender) %>% 
  spread(key = "Race_Gender", value = "Words")
```

    ## # A tibble: 3 x 7
    ##   Film                       Elf_Female Elf_Male Hobbi… Hobbi… Man_… Man_…
    ## * <chr>                           <int>    <int>  <int>  <int> <int> <int>
    ## 1 The Fellowship Of The Ring       1229      971     14   3644     0  1995
    ## 2 The Return Of The King            183      510      2   2673   268  2459
    ## 3 The Two Towers                    331      513      0   2463   401  3589

``` r
lotr_tidy %>% 
  mutate(x = rnorm(nrow(lotr_tidy))) %>% 
  spread(key = "Gender", value = "x")
```

    ## # A tibble: 18 x 5
    ##    Film                       Race   Words   Female    Male
    ##  * <chr>                      <chr>  <int>    <dbl>   <dbl>
    ##  1 The Fellowship Of The Ring Elf      971  NA      - 0.407
    ##  2 The Fellowship Of The Ring Elf     1229 - 0.838   NA    
    ##  3 The Fellowship Of The Ring Hobbit    14   1.04    NA    
    ##  4 The Fellowship Of The Ring Hobbit  3644  NA      - 0.597
    ##  5 The Fellowship Of The Ring Man        0   1.73    NA    
    ##  6 The Fellowship Of The Ring Man     1995  NA        0.401
    ##  7 The Return Of The King     Elf      183   0.463   NA    
    ##  8 The Return Of The King     Elf      510  NA      - 1.75 
    ##  9 The Return Of The King     Hobbit     2   0.0498  NA    
    ## 10 The Return Of The King     Hobbit  2673  NA      - 0.521
    ## 11 The Return Of The King     Man      268   0.831   NA    
    ## 12 The Return Of The King     Man     2459  NA        0.238
    ## 13 The Two Towers             Elf      331   0.912   NA    
    ## 14 The Two Towers             Elf      513  NA        1.35 
    ## 15 The Two Towers             Hobbit     0 - 2.41    NA    
    ## 16 The Two Towers             Hobbit  2463  NA      - 0.621
    ## 17 The Two Towers             Man      401   0.251   NA    
    ## 18 The Two Towers             Man     3589  NA        0.555

## Other `tidyr` goodies

Check out the Examples in the documentation to explore the following.

`expand` vs `complete` (trim vs keep everything). Together with
`nesting`. Check out the Examples in the `expand` documentation.

``` r
expand(mtcars, nesting(vs, cyl))
```

    ## # A tibble: 5 x 2
    ##      vs   cyl
    ##   <dbl> <dbl>
    ## 1  0     4.00
    ## 2  0     6.00
    ## 3  0     8.00
    ## 4  1.00  4.00
    ## 5  1.00  6.00

``` r
df <- tibble(
  year   = c(2010, 2010, 2010, 2010, 2012, 2012, 2012),
  qtr    = c(   1,    2,    3,    4,    1,    2,    3),
  return = rnorm(7)
)
df %>% expand(year, qtr)
```

    ## # A tibble: 8 x 2
    ##    year   qtr
    ##   <dbl> <dbl>
    ## 1  2010  1.00
    ## 2  2010  2.00
    ## 3  2010  3.00
    ## 4  2010  4.00
    ## 5  2012  1.00
    ## 6  2012  2.00
    ## 7  2012  3.00
    ## 8  2012  4.00

``` r
df %>% expand(year = 2010:2012, qtr)
```

    ## # A tibble: 12 x 2
    ##     year   qtr
    ##    <int> <dbl>
    ##  1  2010  1.00
    ##  2  2010  2.00
    ##  3  2010  3.00
    ##  4  2010  4.00
    ##  5  2011  1.00
    ##  6  2011  2.00
    ##  7  2011  3.00
    ##  8  2011  4.00
    ##  9  2012  1.00
    ## 10  2012  2.00
    ## 11  2012  3.00
    ## 12  2012  4.00

``` r
df %>% expand(year = full_seq(year, 1), qtr)
```

    ## # A tibble: 12 x 2
    ##     year   qtr
    ##    <dbl> <dbl>
    ##  1  2010  1.00
    ##  2  2010  2.00
    ##  3  2010  3.00
    ##  4  2010  4.00
    ##  5  2011  1.00
    ##  6  2011  2.00
    ##  7  2011  3.00
    ##  8  2011  4.00
    ##  9  2012  1.00
    ## 10  2012  2.00
    ## 11  2012  3.00
    ## 12  2012  4.00

``` r
df %>% complete(year = full_seq(year, 1), qtr)
```

    ## # A tibble: 12 x 3
    ##     year   qtr  return
    ##    <dbl> <dbl>   <dbl>
    ##  1  2010  1.00 - 0.309
    ##  2  2010  2.00 - 1.18 
    ##  3  2010  3.00   1.38 
    ##  4  2010  4.00   0.640
    ##  5  2011  1.00  NA    
    ##  6  2011  2.00  NA    
    ##  7  2011  3.00  NA    
    ##  8  2011  4.00  NA    
    ##  9  2012  1.00 - 2.37 
    ## 10  2012  2.00   0.221
    ## 11  2012  3.00   0.468
    ## 12  2012  4.00  NA

``` r
experiment <- tibble(
  name = rep(c("Alex", "Robert", "Sam"), c(3, 2, 1)),
  trt  = rep(c("a", "b", "a"), c(3, 2, 1)),
  rep = c(1, 2, 3, 1, 2, 1),
  measurment_1 = runif(6),
  measurment_2 = runif(6)
)
experiment
```

    ## # A tibble: 6 x 5
    ##   name   trt     rep measurment_1 measurment_2
    ##   <chr>  <chr> <dbl>        <dbl>        <dbl>
    ## 1 Alex   a      1.00        0.704        0.219
    ## 2 Alex   a      2.00        0.358        0.844
    ## 3 Alex   a      3.00        0.764        0.296
    ## 4 Robert b      1.00        0.530        0.860
    ## 5 Robert b      2.00        0.678        0.517
    ## 6 Sam    a      1.00        0.184        0.450

``` r
all <- experiment %>% expand(nesting(name, trt), rep)
all
```

    ## # A tibble: 9 x 3
    ##   name   trt     rep
    ##   <chr>  <chr> <dbl>
    ## 1 Alex   a      1.00
    ## 2 Alex   a      2.00
    ## 3 Alex   a      3.00
    ## 4 Robert b      1.00
    ## 5 Robert b      2.00
    ## 6 Robert b      3.00
    ## 7 Sam    a      1.00
    ## 8 Sam    a      2.00
    ## 9 Sam    a      3.00

`separate_rows`: useful when you have a variable number of entries in a
“cell”.

`unite` and `separate`.

`uncount` (as the opposite of `dplyr::count()`)

`drop_na` and `replace_na`

`fill`

`full_seq`

## Time remaining?

Time permitting, do [this
exercise](https://github.com/jennybc/lotr-tidy/blob/master/02-gather.md#exercises)
to practice tidying data.
