import System.Directory       
import Control.Monad
import System.FilePath
import System.Environment
import Text.ParserCombinators.Parsec
main = do 
  path <- getEnv "PATH"
  split :: String -> String -> [String]
  let prefixes = split path ":"
  vs <- forM prefixes $ \p -> do
    fs <- getContents p
    return $ zip fs $ repeat p
  let hash = accumalate $ concat vs
  forM_ (keys hash) $ \k -> do
    if length (hash ! k) > 1 
      then print "File " ++ k ++ " is not unique in $PATH"
      else return ()
